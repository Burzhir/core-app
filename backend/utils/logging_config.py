import logging

class RequestIdFilter(logging.Filter):
    def filter(self, record):
        from flask import has_request_context, g
        record.req_id = getattr(g, 'req_id', '?') if has_request_context() else '?'
        return True

def setup_logging():
    handler = logging.StreamHandler()
    handler.setFormatter(logging.Formatter(
        '[%(asctime)s] %(levelname)s req=%(req_id)s %(message)s'
    ))
    handler.addFilter(RequestIdFilter())
    logging.basicConfig(level=logging.INFO, handlers=[handler])