from kafka.admin import KafkaAdminClient, NewTopic

def create_topics(topic_names):
    admin_client = KafkaAdminClient(
        bootstrap_servers="kafka:29092", 
        client_id='my_app'
    )

    topics = [NewTopic(name, num_partitions=1, replication_factor=1) for name in topic_names]
    admin_client.create_topics(new_topics=topics, validate_only=False)
