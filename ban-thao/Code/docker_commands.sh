# build the image from Gazebo Jetty (pinned digest)
docker compose build pipeline

# run the whole pipeline as the host user
FUNNEL_UID=$(id -u) FUNNEL_GID=$(id -g) \
  docker compose run --rm pipeline python3 main.py --no-ask

# one goal, no GUI
docker compose run --rm pipeline python3 main.py simulate --goal g2 --headless

# software rendering when no GPU is available
docker compose run --rm pipeline-software python3 main.py simulate --goal g2
