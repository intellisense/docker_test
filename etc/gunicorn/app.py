import multiprocessing
import os

bind = '0.0.0.0:8000'

default_workers = multiprocessing.cpu_count() * 2 + 1
workers = os.getenv('GUNICORN_WORKERS', os.getenv('WEB_CONCURRENCY', default_workers))
worker_class = 'tornado'

# This is to fix issues with compressor package: broken offline manifest for
# custom domain. It randomly breaks, I think because of global variable inside.
preload_app = True

timeout = 200
graceful_timeout = 60
max_requests = 250
max_requests_jitter = max_requests
accesslog = '/tmp/gunicorn_access.log'
errorlog = '/tmp/gunicorn_error.log'
