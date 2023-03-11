# serverless-aws-instance-scheduler-docker
## このリポジトリについて
 - AWSのリソース(EC2,Lightsail)を指定時間で起動/停止するスケジューラのDocker動作環境を構築するリポジトリです
   - EC2とLightsailについて指定の時間で起動と停止のスケジュールを作成するフロントエンドツールを起動します
   - 作成したスケジュール設定を元にServerless Frameworkを介してAWS Lambdaにデプロイします
 - ご使用になるにはAWSのアクセスキーとシークレットアクセスキー(IAM)が必要です
   - また、IAMのポリシーとして後述する内容が必要です

## IAMのポリシーについて
以下のポリシーが必要となっています
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "logs:DeleteLogGroup",
                "cloudformation:DescribeStackResource",
                "cloudformation:CreateChangeSet",
                "logs:TagResource",
                "s3-object-lambda:*",
                "logs:CreateLogGroup",
                "logs:DeleteLogStream",
                "cloudformation:DeleteChangeSet",
                "cloudformation:DescribeStacks",
                "iam:*",
                "logs:CreateLogStream",
                "cloudformation:DescribeStackEvents",
                "cloudformation:GetTemplate",
                "cloudformation:DeleteStack",
                "lambda:*",
                "cloudformation:DescribeChangeSet",
                "events:*",
                "cloudformation:ExecuteChangeSet",
                "cloudformation:ValidateTemplate",
                "cloudformation:ListStackResources",
                "lightsail:StartInstance",
                "ec2:DescribeInstances",
                "ec2:StartInstances",
                "lightsail:GetInstances",
                "lightsail:StopInstance",
                "ec2:StopInstances"
            ],
            "Resource": "*"
        }
    ]
}
```

## 環境構築手順
1. (初回のみ) 当リポジトリをクローン、.envコピー

```
$ git clone https://github.com/imo-tikuwa/serverless-aws-instance-scheduler-docker.git
$ cd serverless-aws-instance-scheduler-docker
$ cp .env.example .env
```

2. (初回のみ) .envの中の`AWS_ACCESS_KEY_ID`,`AWS_SECRET_ACCESS_KEY`について設定

```
AWS_ACCESS_KEY_ID=[AWSのアクセスキー]
AWS_SECRET_ACCESS_KEY=[AWSのシークレットアクセスキー]

SERVERLESS_SERVICE_NAME=serverless-aws-instance-scheduler
```

3. (初回のみ) Dockerイメージをビルド

```
$ docker-compose build
```

4. (2回目以降) 作成したイメージからコンテナを起動

```
$ docker-compose up -d
```

## フロントエンドツールの使い方
1. コンテナを起動している状態でブラウザで http://localhost/ にアクセス
2. 画面でスケジュール管理したいインスタンスを選択、アクションのタイプ(start or stop)を選択、アクションを起こしたい曜日などの情報を入力
  - 保存ボタンを押すことで現在の入力をローカルストレージに保存することができます
3. 反映ボタンからevent.jsonとschedule.ymlを生成します

## Serverless Frameworkによるデプロイ
`※先にフロントエンドツールで反映を行っておく必要があります`

1. 以下のコマンドからデプロイが行えます
```
$ make sls-deploy
```
`※makeコマンドが使えない環境の場合はMakefile内に記載のコマンドよりデプロイが行えます`

## 免責事項
- 本アプリケーションの利用によって、使用者が被った損失、損害、不都合などに対して、作者は一切の責任を負いません。

## リポジトリ構成について
 - Dockerfile内のコードにより以下の3リポジトリをコンテナ内にクローンします
   - https://github.com/imo-tikuwa/serverless-aws-instance-scheduler-app-dist
     - Nuxt3で作ったアプリケーションのnode-server用のビルドを行ったファイル一式を管理しています
   - https://github.com/imo-tikuwa/serverless-aws-instance-scheduler-opt-submodule
     - Serverless Frameworkのserverless-layersプラグインでレイヤーとしてデプロイされるファイル一式を管理しています
   - https://github.com/imo-tikuwa/serverless-aws-instance-scheduler-serverless-submodule
     - Serverless Frameworkのコード一式を管理しています