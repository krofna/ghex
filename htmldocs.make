helpdir = $(datadir)/gnome/help/$(docname)/$(lang)

#Scrollkeeper related stuff
omf_dir=$(top_srcdir)/omf-install

EXTRA_DIST = $(htmls) $(omffiles) $(figs)

CLEANFILES = omf_timestamp

all: omf

omf: omf_timestamp

omf_timestamp: $(omffiles)
	-for omffile in $(omffiles); do \
	  scrollkeeper-preinstall $(DESTDIR)$(helpdir)/index.html $$omffile $(omf_dir)/$$omffile; \
	done
	touch omf_timestamp

app-dist-hook:
	-cp $(srcdir)/*.html $(distdir)/$(docname)
	-cp $(srcdir)/*.png $(distdir)/$(docname)

install-data-am: omf
	-for file in $(srcdir)/*.html; do \
	  basefile=`echo $$file | sed -e 's,^.*/,,'`; \
	  $(INSTALL_DATA) $$file $(DESTDIR)$(helpdir)/$$basefile; \
	done
	-for file in $(srcdir)/*.png; do \
	  basefile=`echo $$file | sed -e  's,^.*/,,'`; \
	  $(INSTALL_DATA) $$file $(DESTDIR)$(helpdir)/$$basefile; \
	done
