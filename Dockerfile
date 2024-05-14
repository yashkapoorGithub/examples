FROM golang:1.10.0 as builder

# Install dependencies
RUN go get github.com/codegangsta/negroni \
           github.com/gorilla/mux \
           github.com/xyproto/simpleredis

WORKDIR /app

# Clone the repository
RUN git clone github.com/kubernetes/examples/tree/master/guestbook-go/public

# Build the main.go file
ADD ./main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

FROM scratch

# Set the working directory
WORKDIR /app

# Copy the main executable from the builder stage
COPY --from=builder /app/main .

# Copy files from the cloned repository
COPY --from=builder /tmp/public/index.html public/index.html
COPY --from=builder /tmp/public/script.js public/script.js
COPY --from=builder /tmp/public/style.css public/style.css

# Define the command to run the main executable
CMD ["/app/main"]

# Expose port 3000
EXPOSE 3000
