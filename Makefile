format:
	@swiftformat \
		--stripunusedargs "closure-only" \
		--indent 2 \
		--wraparguments before-first \
		--wrapcollections before-first \
		--swiftversion 5.1 \
		--self insert \
		.