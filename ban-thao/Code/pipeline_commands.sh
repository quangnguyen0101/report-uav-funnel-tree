# stage data: fixtures, scene, surface, images, mission
python3 main.py data

# stage plan: Funnel Tree, route images, reference comparison
python3 main.py plan

# stage simulate: world, flight, telemetry; one goal, no GUI
python3 main.py simulate --goal g2 --headless

# run all three stages and keep the result as an archive
python3 main.py --label cell4

# compare archives and check every image stamp
python3 tools/plan/compare_runs.py
python3 tools/figures.py
