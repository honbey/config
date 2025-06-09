#!/usr/bin/env python3

import argparse
import json
import random
import sys
import time
from datetime import datetime, timezone

import requests
import yaml


def push2gotify(title: str, msg: str, url: str, token: str, priority: int = 5):
    """
    Push notification to Gotify.

    Params:
    title (str): notification title
    message (str): notification message
    url (str): Gotify server URL
    token (str): Gotify token
    priority (int): notification priority
    """

    url = f"{url}/message"
    headers = {"X-Gotify-Key": token, "Content-Type": "application/json"}
    data = {"title": title, "message": msg, "priority": priority}

    try:
        response = requests.post(url, headers=headers, json=data)
        response.raise_for_status()
        print("Push update notification to Gotify...")
    except requests.exceptions.RequestException as e:
        print(f"[error]: Push notification to Gotify failed. error msg: {e}")


def main():
    # 处理命令行参数
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-f",
        "--force",
        required=False,
        action="store_true",
        default=False,
        help="Don't wait, enforce this script",
        dest="force",
    )
    parser.add_argument("config", type=str, help="The path of config file")
    args = parser.parse_args()
    with open(args.config) as f:
        cfg = yaml.safe_load(f)
        token = cfg.get("token")
        gotify = cfg.get("gotify")

    # 非强制模式时随机等待
    if not args.force:
        wait_seconds = random.randint(300, 1499)  # 300~1499秒
        time.sleep(wait_seconds)

    # 记录请求开始时间 (UTC)
    start_time = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

    # 公共请求头
    common_headers = {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "Connection": "keep-alive",
        "Origin": "https/hybrid-sapp.chery.cn",
        "Referer": "https/hybrid-sapp.chery.cn/",
        "User-Agent": "Mozilla/5.0 (Linux; Android 12; ZTE A2023P Build/SKQ1.220213.001; wv) "
        "AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 "
        "Chrome/99.0.4844.88 Mobile Safari/537.36 android/1.0.0",
        "X-Requested-With": "com.digitalmall.chery",
        "Sec-Fetch-Site": "same-site",
        "Sec-Fetch-Mode": "cors",
        "Sec-Fetch-Dest": "empty",
    }

    # 构建URL
    url = (
        f"https://mobile-consumer-sapp.chery.cn/web/event/trigger?access_token={token}"
    )

    try:
        # 发送OPTIONS请求 (预检请求)
        options_headers = common_headers.copy()
        options_headers.update(
            {
                "Access-Control-Request-Headers": "authorization,content-type",
                "Access-Control-Request-Method": "POST",
                "Accept-Language": "zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7",
            }
        )
        requests.options(url, headers=options_headers)

        # 发送POST请求
        post_headers = common_headers.copy()
        post_headers.update(
            {
                "Authorization": f"Bearer {token}",
                "Content-Type": "application/json",
                "Accept-Language": "zh-CN,zh",
            }
        )

        response = requests.post(
            url, headers=post_headers, json={"eventCode": "SJ10002"}
        )
        response.raise_for_status()

        # 记录响应处理时间 (UTC)
        check_time = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

        # 解析JSON响应
        try:
            res_data = response.json()
            status, message = res_data.get("status"), res_data.get("message")
            result = {
                "time": start_time,
                "check_time": check_time,
                "status": status,
                "message": message,
            }
            if message != "操作成功s":
                push2gotify(
                    "Chery Auto Checkout",
                    "Token is expired, please change!",
                    gotify.get("url"),
                    gotify.get("token"),
                    priority=8,
                )
            print(json.dumps(result, separators=(",", ":"), ensure_ascii=False))
        except ValueError:
            # JSON解析失败时输出原始响应
            print(response.text)
            sys.exit(0)

    except requests.exceptions.RequestException as e:
        print(f"Request failed: {str(e)}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
