# Use an official Python runtime as the base image
FROM python:3.9-slim-buster

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the necessary packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Collect static files
RUN python manage.py collectstatic --no-input

# Expose the port 8000 for the application
EXPOSE 8000

# Start the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# use the nginx image
FROM nginx:latest

# copy the nginx configuration
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# copy the static files 
COPY --from=0 /static /static

#Expose port 80 for nginx
EXPOSE 80

# Start Nginx
# CMD ["nginx", "-g", "daemon off;"]
