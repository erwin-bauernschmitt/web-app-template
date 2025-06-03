#------------------------------------------------------------------------------
# Gunicorn Configuration for Back End Container
#
# This Gunicorn configuration file specifies how the Gunicorn server should log
# and how many worker processes it should spawn. 
#
# Maintainer: erwin-bauernschmitt 
# Last reviewed: 02/06/2025
#------------------------------------------------------------------------------

import multiprocessing

# Bind and port
bind = "0.0.0.0:8000"

# Define paths for the two logfiles
accesslog = "/var/log//backend/gunicorn-access.log"
errorlog = "/var/log/backend/gunicorn-error.log"

# Set log level
loglevel = "info"

# Define worker settings
workers = 2
# Set workers = 2 for lower RAM usage, can match CPU with:
    # workers = multiprocessing.cpu_count() * 2 + 1

# Capture Django stdout in the error log
capture_output = True