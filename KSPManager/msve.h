
#include "pe.h"

#define VS_FIXEDFILEINFO_SIGNATURE 0xfeef04bd

enum {
  VS_FF_DEBUG        = 0x001,
  VS_FF_INFOINFERRED = 0x010,
  VS_FF_PATCHED      = 0x004,
  VS_FF_PRERELEASE   = 0x002,
  VS_FF_PRIVATEBUILD = 0x008,
  VS_FF_SPECIALBUILD = 0x020
};

enum {
  VOS_DOS       = 0x00010000,
  VOS_NT        = 0x00040000,
  VOS_WINDOWS16 = 0x00000001,
  VOS_WINDOWS32	= 0x00000004,

  VOS_OS216	= 0x00020000,
  VOS_OS232	= 0x00030000,
  VOS_PM16	= 0x00000002,
  VOS_PM32	= 0x00000003,
  VOS_UNKNOWN   = 0x00000000
};

enum {
  VFT_UNKNOWN	 = 0x00000000,
  VFT_APP        = 0x00000001,
  VFT_DLL	 = 0x00000002,
  VFT_DRV	 = 0x00000003,
  VFT_FONT	 = 0x00000004,
  VFT_VXD        = 0x00000005,
  VFT_STATIC_LIB = 0x00000007,
};

typedef struct {
  DWORD dwSignature;		/* used with with szKey to find struct in file, VS_FIXEDFILEINFO_SIGNATURE */
  DWORD dwStrucVersion;		/* packed field - hi word: major lo word: minor */
  DWORD dwFileVersionMS;	/* MSB of file binary version number */
  DWORD dwFileVersionLS;	/* LSB of file binary version number */
  DWORD dwProductVersionMS;	/* MSB of product file version number */
  DWORD dwProductVersionLS;	/* LSB of product file version number */
  DWORD dwFileFlagsMask;	/* Mask of valid parts of dwFileFlags */
  DWORD dwFileFlags;		/* Bit mask constructed with VS_FF_* */
  DWORD dwFileOS;           /* Bit mask of VOS_* */
  DWORD dwFileType;         /* VFT_* */
  DWORD dwFileSubtype;		/* file sub types, dnc */
  DWORD dwFileDateMS;		/* MSB of datetimestamp */
  DWORD dwFileDateLS;		/* LSB of datetimestamp */
} VS_FIXEDFILEINFO;

typedef struct {
  WORD             wLength;
  WORD             wValueLength;
  WORD             wType;
  WCHAR            szKey[1];
} VS_VARLENGTH;

typedef struct {
  WORD             wLength;	     /* length of this struct */
  WORD             wValueLength; /* length in bytes of Value member */
  WORD             wType;	     /* 0: binary 1: text */
  WCHAR            szKey[15];	 /* Unicode string "VS_VERSION_INFO" */
  WORD             pad0;
  VS_FIXEDFILEINFO Value;	     /*  */
  WORD             Padding2;	 /* variable zeros to 32 bit boundary */
  WORD             Children;	 /* Array of 0|1 StringFileInfo and 0|1 VarFileInfo structs */
} VS_VERSIONINFO;

typedef struct {
  WORD  wLength;		/* length in bytes of this structure (Leaf) */
  WORD  wValueLength;   /* size in WORDS of Value member */
  WORD  wType;			/* 0: binary 1: text */
  WCHAR szKey;			/* arbitrary unicode string */
  WORD  Padding;		/* variable zeros to 32 bit boundary */
  WORD  Value;			/* zero terminated string ( C string?) */
} String;

typedef struct {
  WORD   wLength;		/* length in bytes of this struct including children */
  WORD   wValueLength;	/* always zero */
  WORD   wType;			/* 0: binary 1: text */
  WCHAR  szKey;			/* 8 digit hex unicode string, encodes language identifier */
  WORD   Padding;
  String Children;		/* array >= of String */
} StringTable;

typedef struct {
  WORD        wLength;		/* length in byts of entire StringFileInfo block including children */
  WORD        wValueLength;	/* always zero */
  WORD        wType;		/* 0: binary 1: text */
  WCHAR       szKey;		/* Unicode string "StringFileInfo" */
  WORD        Padding;
  StringTable Children;		/* array >=1 of StrangTable */
} StringFileInfo;


typedef struct {
  WORD  wLength;		/* Length in bytes of Var structure */
  WORD  wValueLength;		/* length in bytes of Value member */
  WORD  wType;			/* 0: binary 1: text */
  WCHAR szKey;			/* unicode string "Translation" */
  WORD  Padding;		/* pad out to 32 bit boundary */
  DWORD Value;			/* array >= 1 of DWORD lang/code page pairs */
} Var;

/* VAR Value: Array of DWORD:[WORD:IBM code page,WORD: MS Lang Id] */

typedef struct {
  WORD  wLength;		/* length in byts of entire VarFileInfo block including children */
  WORD  wValueLength;		/* always 0 */
  WORD  wType;			/* 0: binary 1: text */
  WCHAR szKey;			/* unicode string "VarFileInfo" */
  WORD  Padding;		/* bad out to 32 bit boundary */
  Var   Children;		/* array of  */
} VarFileInfo;
