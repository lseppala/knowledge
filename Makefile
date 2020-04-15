ALL_MD_FILES=$(shell find . -type file -name '*.md' | grep -v 'SUMMARY.md')

update: SUMMARY.md
	@for i in `git add . && git diff --cached --name-only`; do\
		changed="$${changed:-}$${changed:+ }$$i"; \
	done; git commit -m "$$changed" && git push


# `book` is https://www.npmjs.com/package/gitbook-summary
SUMMARY.md: book.json $(ALL_MD_FILES)
	@book summary
