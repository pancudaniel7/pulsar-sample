from pulsar import Function

class FirstFunction(Function):
    def __init__(self):
        pass

    def process(self, input, context):
        logger = context.get_logger()        
        context.publish("persistent://public/default/o1", input)
        logger.info("Test logging data <----<")