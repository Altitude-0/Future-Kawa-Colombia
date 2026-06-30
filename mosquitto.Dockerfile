FROM eclipse-mosquitto:2.0
RUN echo "listener 1883" > /mosquitto/config/mosquitto.conf && echo "allow_anonymous true" >> /mosquitto/config/mosquitto.conf
