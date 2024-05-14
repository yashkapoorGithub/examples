FROM golang:1.10.0 as builder

# Install dependencies
RUN go get github.com/codegangsta/negroni \
           github.com/gorilla/mux \
           github.com/xyproto/simpleredis

WORKDIR /app

# Clone the repository
RUN git clone github.com/kubernetes/examples/tree/master/guestbook-go/public


FROM scratch

# Set the working directory
WORKDIR /app

# Define the command to run the main executable
CMD ["/app/main"]

# Expose port 3000
EXPOSE 3000
