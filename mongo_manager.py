from pymongo import MongoClient
import datetime


class MongoDBManager:
    def __init__(self):
        self.client = MongoClient('mongodb://root:example@localhost:27017/')
        self.db = self.client['chat_app']
        self.messages_collection = self.db['messages']

    def save_message(self, channel, author, message):
        message_data = {
            'timestamp': datetime.datetime.utcnow(),
            'author': author,
            'channel': channel,
            'message': message
        }
        self.messages_collection.insert_one(message_data)

    def get_messages_by_channel(self, channel):
        messages = self.messages_collection.find({'channel': channel}).sort('timestamp', -1)
        return list(messages)
