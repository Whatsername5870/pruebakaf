from kafka import KafkaProducer, KafkaConsumer
import threading
from mongo_manager import MongoDBManager
import threading
import datetime
import os
KAFKA_BROKER = 'localhost:9092'
mongo_manager = MongoDBManager()
current_channel = None
producer = None
consumer = None

def produce_message(topic_name, message):
    producer = KafkaProducer(bootstrap_servers=[KAFKA_BROKER])
    producer.send(topic_name, message.encode('utf-8'))
    producer.flush()
    # Guardar mensaje en MongoDB
    mongo_manager.save_message(current_channel, 'Usuario', message)

def send_message():
    global producer, current_channel
    if not current_channel:
        print("No se ha seleccionado ningún canal. Por favor, cambie de canal primero.")
        return
    message = input("Ingrese su mensaje: ")
    produce_message(current_channel, message)

def change_channel():
    global current_channel, consumer
    new_channel = input("Ingrese el nuevo canal: ")
    if new_channel != current_channel:
        current_channel = new_channel
        if consumer:
            consumer.close()  
        consumer = consume_messages(current_channel, should_print=False) 
        print(f"Cambiado al canal {current_channel}")

def consume_messages(topic_name, should_print=True):
    consumer = KafkaConsumer(
        topic_name,
        bootstrap_servers=[KAFKA_BROKER],
        auto_offset_reset='earliest',
        group_id='my-group',
        consumer_timeout_ms=1000
    )
    def consume():
        for message in consumer:
            if should_print:
                print(f"Nuevo mensaje en {topic_name}: {message.value.decode('utf-8')}")
    thread = threading.Thread(target=consume)
    thread.start()
    return consumer

def read_previous_messages():
    """ Lee los mensajes anteriores del canal actual. """
    global current_channel
    if not current_channel:
        print("No se ha seleccionado ningún canal.")
        return

    messages = mongo_manager.get_messages_by_channel(current_channel)
    for message in messages:
        print(f"{message['timestamp']} - {message['author']}: {message['message']}")


def main_menu():
    while True:
        print("\n1. Enviar mensaje")
        print("2. Cambiar de canal")
        print("3. Leer mensajes anteriores")
        print("4. Salir")
        choice = input("Seleccione una opción: ")
        
        if choice == '1':
            send_message()
        elif choice == '2':
            change_channel()
        elif choice == '3':
            read_previous_messages()
        elif choice == '4':
            print("Saliendo...")
            break
        else:
            print("Opción no válida, intente de nuevo.")

if __name__ == '__main__':
    initial_channel = input("Ingrese el canal inicial para leer/escribir: ")
    current_channel = initial_channel
    consumer = consume_messages(current_channel, should_print=True)
    main_menu()