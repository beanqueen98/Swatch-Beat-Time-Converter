MODULE 'dos/dos','locale', 'libraries/locale'

DEF loc:PTR TO locale
DEF ds:datestamp
DEF bmtminutes
DEF bmtseconds
DEF beattime

PROC main()

    //Open Library
    IF (localebase:=OpenLibrary('locale.library',47))<>NIL
    loc := OpenLocale(NIL)
    DateStamp(ds)

    //Calculating Beat Time
    bmtminutes := ds.minute + loc.gmtoffset + 60
    bmtseconds := bmtminutes * 60
    beattime := bmtseconds / 86.4
    //This is needed otherwise certain timezones will report over 1000.beats
    IF beattime > 1000 THEN beattime := beattime - 1000
    WriteF('The current internet-time is: @\d\n', beattime)

    //Closing libraries
    CloseLocale(loc)
    CloseLibrary(localebase)
    
    ELSE
    WriteF('Could not open locale.library, version 47+')
    ENDIF
    
ENDPROC