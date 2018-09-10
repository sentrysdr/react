# Must have `sentry-cli` installed globally
# Following variable must be passed in
#  SENTRY_AUTH_TOKEN

SENTRY_ORG=testorg-az
SENTRY_PROJECT=sdr-react
VERSION=`sentry-cli releases propose-version`
PREFIX=static/js
REPO=react


setup_release: create_release associate_commits upload_sourcemaps

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) \
        set-commits $(VERSION) --commit "$(REPO)@$(VERSION)"

upload_sourcemaps:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) files $(VERSION) \
		upload-sourcemaps --url-prefix "~/$(PREFIX)" --validate build/$(PREFIX)
