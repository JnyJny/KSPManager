#ifndef __PE_H
#define __PE_H

#define SU1s
#define SU2s2
#define SU3s3
#define UU1u
#define UU2u2

typedef uint8_t   BYTE;
typedef uint16_t  WORD;
typedef uint32_t DWORD;
typedef uint64_t QWORD;
typedef WORD     WCHAR;

#define IMAGE_DOS_SIGNATURE                 0x5A4D      /* MZ */
#define IMAGE_DOS_SIGNATURE_REV             0x4D5A      /* ZM */
#define IMAGE_OS2_SIGNATURE                 0x454E      /* NE */
#define IMAGE_OS2_SIGNATURE_LE              0x454C      /* LE */
#define IMAGE_VXD_SIGNATURE                 0x454C      /* LE */
#define IMAGE_NT_SIGNATURE                  0x00004550  /* PE00 */

#pragma pack(push, 2)                   /* 16 bit headers are 2 byte packed*/

typedef struct IMAGE_DOS_HEADER {     
  /* DOS .EXE header */
  uint16_t  e_magic;		      /* Magic number */
  uint16_t  e_cblp;                   /* bytes on last page of file */
  uint16_t  e_cp;                     /* Pages in file */
  uint16_t  e_crlc;                   /* Relocations */
  uint16_t  e_cparhdr;                /* Size of header in paragraphs */
  uint16_t  e_minalloc;               /* Minimum extra paragraphs needed */
  uint16_t  e_maxalloc;               /* Maximum extra paragraphs needed */
  uint16_t  e_ss;                     /* Initial (relative) SS value */
  uint16_t  e_sp;                     /* Initial SP value */
  uint16_t  e_csum;                   /* Checksum */
  uint16_t  e_ip;                     /* Initial IP value */
  uint16_t  e_cs;                     /* Initial (relative) CS value */
  uint16_t  e_lfarlc;                 /* File address of relocation table */
  uint16_t  e_ovno;                   /* Overlay number */
  uint16_t  e_res[4];                 /* Reserved words */
  uint16_t  e_oemid;                  /* OEM identifier (for e_oeminfo) */
  uint16_t  e_oeminfo;                /* OEM information; e_oemid specific */
  uint16_t  e_res2[10];               /* Reserved words */
  uint32_t  e_lfanew;                 /* File address of new exe header */
} IMAGE_DOS_HEADER;

#pragma pack(pop)

#pragma pack(push, 1)

typedef struct IMAGE_FILE_HEADER {
  uint16_t  Machine;
  uint16_t  NumberOfSections;
  uint32_t  TimeDateStamp;
  uint32_t  PointerToSymbolTable;
  uint32_t  NumberOfSymbols;
  uint16_t  SizeOfOptionalHeader;
  uint16_t  Characteristics;
} IMAGE_FILE_HEADER;

typedef struct IMAGE_DATA_DIRECTORY {
  uint32_t   VirtualAddress;
  uint32_t   Size;
} IMAGE_DATA_DIRECTORY;

#define IMAGE_NUMBEROF_DIRECTORY_ENTRIES    16

typedef struct IMAGE_OPTIONAL_HEADER {
  uint16_t  Magic;
  uint8_t   MajorLinkerVersion;
  uint8_t   MinorLinkerVersion;
  uint32_t  SizeOfCode;
  uint32_t  SizeOfInitializedData;
  uint32_t  SizeOfUninitializedData;
  uint32_t  AddressOfEntryPoint;
  uint32_t  BaseOfCode;
  uint32_t  BaseOfData;
  uint32_t  ImageBase;
  uint32_t  SectionAlignment;
  uint32_t  FileAlignment;
  uint16_t  MajorOperatingSystemVersion;
  uint16_t  MinorOperatingSystemVersion;
  uint16_t  MajorImageVersion;
  uint16_t  MinorImageVersion;
  uint16_t  MajorSubsystemVersion;
  uint16_t  MinorSubsystemVersion;
  uint32_t  Win32VersionValue;
  uint32_t  SizeOfImage;
  uint32_t  SizeOfHeaders;
  uint32_t  CheckSum;
  uint16_t  Subsystem;
  uint16_t  DllCharacteristics;
  uint32_t  SizeOfStackReserve;
  uint32_t  SizeOfStackCommit;
  uint32_t  SizeOfHeapReserve;
  uint32_t  SizeOfHeapCommit;
  uint32_t  LoaderFlags;
  uint32_t  NumberOfRvaAndSizes;
  IMAGE_DATA_DIRECTORY DataDirectory[IMAGE_NUMBEROF_DIRECTORY_ENTRIES];
} IMAGE_OPTIONAL_HEADER;

#define IMAGE_SIZEOF_SHORT_NAME              8

typedef struct IMAGE_SECTION_HEADER {
  uint8_t    Name[IMAGE_SIZEOF_SHORT_NAME];
  union {
    uint32_t   PhysicalAddress;
    uint32_t   VirtualSize;
  } Misc;
  uint32_t   VirtualAddress;
  uint32_t   SizeOfRawData;
  uint32_t   PointerToRawData;
  uint32_t   PointerToRelocations;
  uint32_t   PointerToLinenumbers;
  uint16_t    NumberOfRelocations;
  uint16_t    NumberOfLinenumbers;
  uint32_t   Characteristics;
} IMAGE_SECTION_HEADER;

typedef struct IMAGE_BASE_RELOCATION {
  uint32_t   VirtualAddress;
  uint32_t   SizeOfBlock;
  /*  uint16_t    TypeOffset[1]; */
} IMAGE_BASE_RELOCATION;

#define IMAGE_FILE_RELOCS_STRIPPED           0x0001  /* Relocation info stripped from file. */
#define IMAGE_FILE_EXECUTABLE_IMAGE          0x0002  /* File is executable  (i.e. no unresolved externel references). */
#define IMAGE_FILE_LINE_NUMS_STRIPPED        0x0004  /* Line nunbers stripped from file. */
#define IMAGE_FILE_LOCAL_SYMS_STRIPPED       0x0008  /* Local symbols stripped from file. */
#define IMAGE_FILE_AGGRESIVE_WS_TRIM         0x0010  /* Agressively trim working set */
#define IMAGE_FILE_BYTES_REVERSED_LO         0x0080  /* Byte of machine word are reversed. */
#define IMAGE_FILE_32BIT_MACHINE             0x0100  /* 32 bit word machine. */
#define IMAGE_FILE_DEBUG_STRIPPED            0x0200  /* Debugging info stripped from file in .DBG file */
#define IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP   0x0400  /* If Image is on removable media, copy and run from the swap file. */
#define IMAGE_FILE_NET_RUN_FROM_SWAP         0x0800  /* If Image is on Net, copy and run from the swap file. */
#define IMAGE_FILE_SYSTEM                    0x1000  /* System File. */
#define IMAGE_FILE_DLL                       0x2000  /* File is a DLL. */
#define IMAGE_FILE_UP_SYSTEM_ONLY            0x4000  /* File should only be run on a UP machine */
#define IMAGE_FILE_BYTES_REVERSED_HI         0x8000  /* Bytes of machine word are reversed. */

#define IMAGE_FILE_MACHINE_UNKNOWN           0
#define IMAGE_FILE_MACHINE_I386              0x14c   /* Intel 386. */
#define IMAGE_FILE_MACHINE_R3000             0x162   /* MIPS little-endian, 0x160 big-endian */
#define IMAGE_FILE_MACHINE_R4000             0x166   /* MIPS little-endian */
#define IMAGE_FILE_MACHINE_R10000            0x168   /* MIPS little-endian */
#define IMAGE_FILE_MACHINE_ALPHA             0x184   /* Alpha_AXP */
#define IMAGE_FILE_MACHINE_POWERPC           0x1F0   /* IBM PowerPC Little-Endian */

#define IMAGE_SUBSYSTEM_UNKNOWN              0   /* Unknown subsystem. */
#define IMAGE_SUBSYSTEM_NATIVE               1   /* Image doesn't require a subsystem. */
#define IMAGE_SUBSYSTEM_WINDOWS_GUI          2   /* Image runs in the Windows GUI subsystem. */
#define IMAGE_SUBSYSTEM_WINDOWS_CUI          3   /* Image runs in the Windows character subsystem. */
#define IMAGE_SUBSYSTEM_OS2_CUI              5   /* image runs in the OS/2 character subsystem. */
#define IMAGE_SUBSYSTEM_POSIX_CUI            7   /* image run  in the Posix character subsystem. */
#define IMAGE_SUBSYSTEM_RESERVED8            8   /* image run  in the 8 subsystem. */

/*      IMAGE_SCN_TYPE_REG                   0x00000000  // Reserved. */
/*      IMAGE_SCN_TYPE_DSECT                 0x00000001  // Reserved. */
/*      IMAGE_SCN_TYPE_NOLOAD                0x00000002  // Reserved. */
/*      IMAGE_SCN_TYPE_GROUP                 0x00000004  // Reserved. */
#define IMAGE_SCN_TYPE_NO_PAD                0x00000008  /* Reserved. */
/*      IMAGE_SCN_TYPE_COPY                  0x00000010  // Reserved. */

#define IMAGE_SCN_CNT_CODE                   0x00000020  /* Section contains code. */
#define IMAGE_SCN_CNT_INITIALIZED_DATA       0x00000040  /* Section contains initialized data. */
#define IMAGE_SCN_CNT_UNINITIALIZED_DATA     0x00000080  /* Section contains uninitialized data. */

#define IMAGE_SCN_LNK_OTHER                  0x00000100  /* Reserved. */
#define IMAGE_SCN_LNK_INFO                   0x00000200  /* Section contains comments or some other type of information. */
/*      IMAGE_SCN_TYPE_OVER                  0x00000400  // Reserved. */
#define IMAGE_SCN_LNK_REMOVE                 0x00000800  /* Section contents will not become part of image. */
#define IMAGE_SCN_LNK_COMDAT                 0x00001000  /* Section contents comdat. */
/*                                           0x00002000  // Reserved. */

/*      IMAGE_SCN_MEM_PROTECTED - Obsolete   0x00004000 */
#define IMAGE_SCN_MEM_FARDATA                0x00008000
/*      IMAGE_SCN_MEM_SYSHEAP  - Obsolete    0x00010000 */
#define IMAGE_SCN_MEM_PURGEABLE              0x00020000
#define IMAGE_SCN_MEM_16BIT                  0x00020000
#define IMAGE_SCN_MEM_LOCKED                 0x00040000
#define IMAGE_SCN_MEM_PRELOAD                0x00080000

#define IMAGE_SCN_ALIGN_1uint8_tS               0x00100000  /* */
#define IMAGE_SCN_ALIGN_2uint8_tS               0x00200000  /* */
#define IMAGE_SCN_ALIGN_4uint8_tS               0x00300000  /* */
#define IMAGE_SCN_ALIGN_8uint8_tS               0x00400000  /* */
#define IMAGE_SCN_ALIGN_16uint8_tS              0x00500000  /* Default alignment if no others are specified. */
#define IMAGE_SCN_ALIGN_32uint8_tS              0x00600000  /* */
#define IMAGE_SCN_ALIGN_64uint8_tS              0x00700000  /* */
/* Unused                                    0x00800000 */

#define IMAGE_SCN_LNK_NRELOC_OVFL            0x01000000  /* Section contains extended relocations. */
#define IMAGE_SCN_MEM_DISCARDABLE            0x02000000  /* Section can be discarded. */
#define IMAGE_SCN_MEM_NOT_CACHED             0x04000000  /* Section is not cachable. */
#define IMAGE_SCN_MEM_NOT_PAGED              0x08000000  /* Section is not pageable. */
#define IMAGE_SCN_MEM_SHARED                 0x10000000  /* Section is shareable. */
#define IMAGE_SCN_MEM_EXECUTE                0x20000000  /* Section is executable. */
#define IMAGE_SCN_MEM_READ                   0x40000000  /* Section is readable. */
#define IMAGE_SCN_MEM_WRITE                  0x80000000  /* Section is writeable. */

/* Directory Entries */

#define IMAGE_DIRECTORY_ENTRY_EXPORT         0   /* Export Directory */
#define IMAGE_DIRECTORY_ENTRY_IMPORT         1   /* Import Directory */
#define IMAGE_DIRECTORY_ENTRY_RESOURCE       2   /* Resource Directory */
#define IMAGE_DIRECTORY_ENTRY_EXCEPTION      3   /* Exception Directory */
#define IMAGE_DIRECTORY_ENTRY_SECURITY       4   /* Security Directory */
#define IMAGE_DIRECTORY_ENTRY_BASERELOC      5   /* Base Relocation Table */
#define IMAGE_DIRECTORY_ENTRY_DEBUG          6   /* Debug Directory */
#define IMAGE_DIRECTORY_ENTRY_COPYRIGHT      7   /* Description String */
#define IMAGE_DIRECTORY_ENTRY_GLOBALPTR      8   /* Machine Value (MIPS GP) */
#define IMAGE_DIRECTORY_ENTRY_TLS            9   /* TLS Directory */
#define IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG   10   /* Load Configuration Directory */
#define IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT  11   /* Bound Import Directory in headers */
#define IMAGE_DIRECTORY_ENTRY_IAT           12   /* Import Address Table */

/* 
 * Based relocation types.
 */

#define IMAGE_REL_BASED_ABSOLUTE              0
#define IMAGE_REL_BASED_HIGH                  1
#define IMAGE_REL_BASED_LOW                   2
#define IMAGE_REL_BASED_HIGHLOW               3
#define IMAGE_REL_BASED_HIGHADJ               4
#define IMAGE_REL_BASED_MIPS_JMPADDR          5
#define IMAGE_REL_BASED_SECTION               6
#define IMAGE_REL_BASED_REL32                 7

/*
 * Export Format
 */

typedef struct IMAGE_EXPORT_DIRECTORY {
  uint32_t   Characteristics;
  uint32_t   TimeDateStamp;
  uint16_t    MajorVersion;
  uint16_t    MinorVersion;
  uint32_t   Name;
  uint32_t   Base;
  uint32_t   NumberOfFunctions;
  uint32_t   NumberOfNames;
  uint32_t  **AddressOfFunctions;
  uint32_t  **AddressOfNames;
  uint16_t   **AddressOfNameOrdinals;
} IMAGE_EXPORT_DIRECTORY;

/*
 * Import Format
 */

typedef struct IMAGE_IMPORT_BY_NAME {
  uint16_t    Hint;
  uint8_t    Name[1];
} IMAGE_IMPORT_BY_NAME;

typedef struct IMAGE_THUNK_DATA {
  union {
    uint8_t*  ForwarderString;
    uint32_t* Function;
    uint32_t Ordinal;
    IMAGE_IMPORT_BY_NAME *AddressOfData;
  } u1;
} IMAGE_THUNK_DATA;

#define IMAGE_ORDINAL_FLAG 0x80000000
#define IMAGE_SNAP_BY_ORDINAL(Ordinal) ((Ordinal & IMAGE_ORDINAL_FLAG) != 0)
#define IMAGE_ORDINAL(Ordinal) (Ordinal & 0xffff)

typedef struct IMAGE_IMPORT_DESCRIPTOR {
  union {
    uint32_t   Characteristics;                /* 0 for terminating null import descriptor */
    IMAGE_THUNK_DATA *OriginalFirstThunk;      /* RVA to original unbound IAT */
  } u;
  uint32_t   TimeDateStamp;                    /* 0 if not bound, */
  /* -1 if bound, and real date\time stamp */
  /*     in IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT (new BIND) */
  /* O.W. date/time stamp of DLL bound to (Old BIND) */

  uint32_t   ForwarderChain;                 /* -1 if no forwarders */
  uint32_t   Name;
  IMAGE_THUNK_DATA *FirstThunk;           /* RVA to IAT (if bound this IAT has actual addresses) */
} IMAGE_IMPORT_DESCRIPTOR;

/* 
 * New format import descriptors pointed to by DataDirectory[ IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT ]
 */

typedef struct IMAGE_BOUND_IMPORT_DESCRIPTOR {
  uint32_t   TimeDateStamp;
  uint16_t    OffsetModuleName;
  uint16_t    NumberOfModuleForwarderRefs;
  /* Array of zero or more IMAGE_BOUND_FORWARDER_REF follows */
} IMAGE_BOUND_IMPORT_DESCRIPTOR;

typedef struct IMAGE_BOUND_FORWARDER_REF {
  uint32_t   TimeDateStamp;
  uint16_t    OffsetModuleName;
  uint16_t    Reserved;
} IMAGE_BOUND_FORWARDER_REF;

typedef struct IMAGE_RESOURCE_DIRECTORY {
  uint32_t   Characteristics;
  uint32_t   TimeDateStamp;
  uint16_t    MajorVersion;
  uint16_t    MinorVersion;
  uint16_t    NumberOfNamedEntries;
  uint16_t    NumberOfIdEntries;
  /*  IMAGE_RESOURCE_DIRECTORY_ENTRY DirectoryEntries[]; */
} IMAGE_RESOURCE_DIRECTORY;

#define IMAGE_GET_RESOURCE_DIRECTORY_ENTRY(RESDIR) \
  (IMAGE_RESOURCE_DIRECTORY_ENTRY *) ((BYTE *)(fRESDIR))+sizeof(IMAGE_RESOURCE_DIRECTORY)

#define IMAGE_RESOURCE_NAME_IS_STRING        0x80000000
#define IMAGE_RESOURCE_DATA_IS_DIRECTORY     0x80000000

/*
 * Each directory contains the 32-bit Name of the entry and an offset,
 * relative to the beginning of the resource directory of the data
 * associated with this directory entry.  If the name of the entry is
 * an actual text string instead of an integer Id, then the high order
 * bit of the name field is set to one and the low order 31-bits are
 * an offset, relative to the beginning of the resource directory of
 * the string, which is of type IMAGE_RESOURCE_DIRECTORY_STRING.
 * Otherwise the high bit is clear and the low-order 16-bits are the
 * integer Id that identify this resource directory entry. If the
 * directory entry is yet another resource directory (i.e. a
 * subdirectory), then the high order bit of the offset field will be
 * set to indicate this.  Otherwise the high bit is clear and the
 * offset field points to a resource data entry.
 */

typedef struct IMAGE_RESOURCE_DIRECTORY_ENTRY {
  union {
    struct {
      uint32_t NameOffset:31;
      uint32_t NameIsString:1;
    } SU1;
    uint32_t   Name;
    uint16_t    Id;
  } UU1;
  union {
    uint32_t   OffsetToData;
    struct {
      uint32_t   OffsetToDirectory:31;
      uint32_t   DataIsDirectory:1;
    } SU1;
  } UU2;
} IMAGE_RESOURCE_DIRECTORY_ENTRY;

/*
 * For resource directory entries that have actual string names, the
 * Name field of the directory entry points to an object of the
 * following type.  All of these string objects are stored together
 * after the last resource directory entry and before the first
 * resource data object.  This minimizes the impact of these variable
 * length objects on the alignment of the fixed size directory entry
 * objects.
 */

typedef struct IMAGE_RESOURCE_DIRECTORY_STRING {
  uint16_t    Length;
  char    NameString[ 1 ];
} IMAGE_RESOURCE_DIRECTORY_STRING;


typedef struct IMAGE_RESOURCE_DIR_STRING_U {
  uint16_t    Length;
  wchar_t NameString[ 1 ];
} IMAGE_RESOURCE_DIR_STRING_U;

/*
 * Each resource data entry describes a leaf node in the resource directory
 * tree.  It contains an offset, relative to the beginning of the resource
 * directory of the data for the resource, a size field that gives the number
 * of bytes of data at that offset, a CodePage that should be used when
 * decoding code point values within the resource data.  Typically for new
 * applications the code page would be the unicode code page.
 */

typedef struct IMAGE_RESOURCE_DATA_ENTRY {
  uint32_t   OffsetToData;
  uint32_t   Size;
  uint32_t   CodePage;
  uint32_t   Reserved;
} IMAGE_RESOURCE_DATA_ENTRY;

typedef struct IMAGE_PE_HEADERS {
  uint32_t Signature;
  IMAGE_FILE_HEADER FileHeader;
  IMAGE_OPTIONAL_HEADER OptionalHeader;
} IMAGE_PE_HEADERS;

#pragma pack(pop)

#define IMAGE_GET_DOS_HEADER(P) (IMAGE_DOS_HEADER *)(P)
#define IMAGE_GET_PE_HEADER(dosheader)  (IMAGE_PE_HEADERS *)((BYTE *)dosheader + (((IMAGE_DOS_HEADER *)(dosheader))->e_lfanew))
#define IMAGE_GET_FIRST_SECTION( peheader )(IMAGE_SECTION_HEADER *)((BYTE *)peheader+sizeof(IMAGE_PE_HEADERS));


#endif

