# Use an official Apache HTTP server image
FROM httpd:2.4

# Set the maintainer label
LABEL maintainer="neehar2601"

# Copy the static website files to the Apache document root(for manual build)
#COPY static-website/ /usr/local/apache2/htdocs/
COPY . /usr/local/apache2/htdocs/

# Expose port 80 to allow web traffic
EXPOSE 80

# Start the Apache server
CMD ["httpd-foreground"]
