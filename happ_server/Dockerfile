# Start from the official Go image
FROM golang:1.18

# Set your working directory
WORKDIR /app

# Copy go.mod and go.sum files to the working directory
COPY go.mod go.sum ./

# Download the Go dependencies
RUN go mod download

# Copy the rest of the source code to the working directory
COPY . .

# Build the binary
RUN go build -o main .

# Expose the port that the server listens on
EXPOSE 8080

# Run the compiled binary
CMD ["./main"]