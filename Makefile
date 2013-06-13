doc: docclean
	doxygen doxygen.conf
	#appledoc -p FoundationExtension --docset-bundle-id=org.youknowone.FoundationExtension F*Extension

docclean:
	rm -rf docs/*
