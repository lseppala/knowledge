ALL_MD_FILES=$(shell find . -type file -name '*.md' | grep -v 'SUMMARY.md')

update: SUMMARY.md
	@for i in `git diff --cached --name-only`; do\
		changed="$$changed `basename $$i`"; \
	done; git commit -a -m "$$changed" && git push


# `book` is https://www.npmjs.com/package/gitbook-summary
SUMMARY.md: book.json $(ALL_MD_FILES)
	@book summary
