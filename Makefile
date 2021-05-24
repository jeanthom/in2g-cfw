aupd-extract: extract2g
	mkdir -p temp
	unzip -n iPod_29.1.1.3.ipsw -d temp
	./extract2g -l temp/Firmware-29.8.1.3
	./extract2g --extract=aupd temp/Firmware-29.8.1.3
	mv aupd.fw temp/
	#./extract2g | grep "aupd" | cut -d " " -f 6

extract2g: extract2g.c extract2g.h
	$(CC) extract2g.c -o $@

clean:
	rm -f extract2g
	rm -rf temp

.PHONY: aupd-extract clean
