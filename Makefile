default: check

build:
	python setup.py build

upload: build
	python setup.py sdist

publish: upload
	# remove development tag
	python setup.py build sdist upload

install: build
	sudo python setup.py install

check:
	# PEP8 scheitert and den QR-code Tabellen.
	pyflakes barcode/ean13/ barcode/datamatrix/ barcode/code128/ barcode/qrcode/*.py examples/
	pep8 -r --ignore=E501 barcode/ean13/ barcode/datamatrix/ barcode/code128/ barcode/qrcode/*.py examples/
	-pylint --max-line-length=110 -d E1101 barcode/ean13/ barcode/datamatrix/ barcode/code128/ examples/ examples/

testenv:
	virtualenv testenv
	testenv/bin/pip install coverage
	testenv/bin/pip install PIL

test:
	PYTHONPATH=.:./barcode python examples/code128.py TESTTEXT
	PYTHONPATH=.:./barcode python test/test_coverage.py

.PHONY: test testenv
