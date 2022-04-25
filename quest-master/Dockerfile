
FROM node:12-buster-slim

# Make and set work directory
RUN mkdir /app
WORKDIR /app

# Copy source code files to work directory
COPY . .

RUN npm install


# Let people know the container port for application
EXPOSE 3000

# Run the executable
CMD ["npm", "start"]