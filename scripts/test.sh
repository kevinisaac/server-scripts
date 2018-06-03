 curl --header "Content-type: application/json" \
    --request POST \
    --data '{
        "channel": "#kevin_private",
        "text": "Someone has deployed Alibalance to the servers! (alibalance.getpreview.io)",
        "attachments": [
            {
                "color": "#3AA3E3",
                "title": "Latest Commit",
                "title_link": "https://github.com/Zephony/alibalance/commits/demo",
                "fields": [
                    {
                        "value": "`923454`:   Put systemctl restart in an conditional check to print correct status",
                    },
                    {
                        "title": "Status",
                        "value": "success",
                        "short": true,
                    },
                    {
                        "title": "Branch",
                        "value": "demo",
                        "short": true,
                    }
                ],
                "author_name": "Kevin",
                "author_link": "https://zephony.com/portfolio",
                "author_icon": "https://assets-cdn.github.com/images/modules/logos_page/GitHub-Mark.png",
                "author_icon": "https://i.imgur.com/1xkPK57.png",
                "footer": "Deployed to DigitalOcean",
                "footer_link": "http://alibalance.getpreview.io/",
                "footer_icon": "https://img.stackshare.io/service/295/DO_Logo_icon_blue.png"
            }
        ]
    }' \
'https://hooks.slack.com/services/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'
