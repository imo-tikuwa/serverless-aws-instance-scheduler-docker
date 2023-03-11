init:
	docker-compose up -d --build

start:
	docker-compose start
stop:
	docker-compose stop
restart:
	docker-compose restart

sls-config:
	docker-compose exec -w /serverless node npx serverless print
sls-debug:
	docker-compose exec -w /serverless node npx serverless invoke local --function RunSchedules -p ./config/event.json
sls-deploy:
	docker-compose exec -w /serverless node npx serverless deploy --verbose
sls-remove:
	docker-compose exec -w /serverless node npx serverless remove --verbose

down:
	docker-compose down
down-all:
	docker-compose down --rmi all --volumes --remove-orphans
