from pulsar import Function
from extendedlogger import extended_logger
from datetime import date


class SecondFunction(Function):

    def __init__(self):
        pass

    def process(self, input, context):
        logger = extended_logger.ExtendedLogger(context.get_logger(), "%s %s", date.today(), "ID45678")
        
        logger.default.info("Test log ---->")
        logger.sens_info("Test logging data <----<")
        logger.sens_debug("Context type: " + type(context).__name__)
        
        context.publish("persistent://public/default/o1", input)
