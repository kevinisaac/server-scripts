import argparse
import sys

from jinja2 import Environment, FileSystemLoader


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument('--site-dir')
    parser.add_argument('--repo-dir')
    parser.add_argument('--co-branch')
    parser.add_argument('--app-name')
    parser.add_argument('--app-repo-name')
    parser.add_argument('--app-url')
    parser.add_argument('--slack-channel')
    parser.add_argument('--new-service-file-name')
    parser.add_argument('--slack-app-url')
    parser.add_argument('--output-file-name')

    args = parser.parse_args()

    # This line uses the current directory
    file_loader = FileSystemLoader('../templates')

    env = Environment(loader=file_loader)
    template = env.get_template('post-receive')
    output = template.render(
        SITE_DIR=args.site_dir or sys.exit('Argument missing'),
        REPO_DIR=args.repo_dir or sys.exit('Argument missing'),
        CO_BRANCH=args.co_branch or sys.exit('Argument missing'),
        APP_NAME=args.app_name or sys.exit('Argument missing'),
        APP_SNAME=args.app_repo_name or sys.exit('Argument missing'),
        APP_URL=args.app_url or sys.exit('Argument missing'),
        SLACK_CHANNEL=args.slack_channel or sys.exit('Argument missing'),
        NEW_SERVICE_FILE_NAME=args.new_service_file_name or sys.exit('Argument missing'),
        SLACK_APP_URL=args.slack_app_url or sys.exit('Argument missing'),
    )

    output_file = args.output_file_name

    with open(output_file, 'w') as f_handler:
        f_handler.write(output)

