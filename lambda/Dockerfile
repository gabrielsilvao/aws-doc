# Use an image that implements the Lambda Runtime API
FROM amazon/aws-lambda-nodejs:12

# Copy your application code and files
COPY app.js package*.json ./

# Install the dependecies in the container
RUN npm install

# Function to run when the Lambda function is invoked
CMD ['app.lambdaHandler']