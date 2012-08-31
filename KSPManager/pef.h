//
//  pef.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/30/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#ifndef KSPManager_pef_h
#define KSPManager_pef_h


typedef unsigned char  BYTE;
typedef unsigned short WORD;
typedef unsigned int   DWORD;

typedef struct {
    WORD e_magic;
    WORD e_cblp;
    WORD e_cp;
    WORD e_crlc;
    WORD e_cparhdr;
    WORD e_minalloc;
    WORD e_maxalloc;
    WORD e_ss;
    WORD e_sp;
    WORD e_csum;
    WORD e_ip;
    WORD e_cs;
    WORD e_lfarlc;
    WORD e_ovno;
    WORD e_res[4];
    WORD e_oemid;
    WORD e_oeminfo;
    WORD e_res2[10];
    DWORD e_lfanew;
} IMAGE_DOS_HEADER;

typedef struct {
    WORD Machine;
    WORD NumberOfSections;
    DWORD TimeDateStamp;
    DWORD PointerToSymbolTable;
    DWORD NumberOfSymbols;
    WORD SizeOfOptionalHeader;
    WORD Characteristics;
} IMAGE_FILE_HEADER;

typedef struct {
    BYTE Name[8];
    union {
        DWORD PhysicalAddress;
        DWORD VirtualSize;
    } Misc;
    DWORD VirtualAddress;
    DWORD SizeOfRawData;
    DWORD PointerToRawData;
    DWORD PointerToRelocations;
    DWORD PointerToLinenumbers;
    WORD  NumberOfRelocations;
    WORD  NumberOfLinenumbers;
    DWORD Characteristics;
} IMAGE_SECTION_HEADER;


typedef struct {
    DWORD VirtualAddress;
    DWORD Size;
} IMAGE_DATA_DIRECTORY;

typedef struct
{
    DWORD                   cb;
    WORD                    MajorRuntimeVersion;
    WORD                    MinorRuntimeVersion;
    IMAGE_DATA_DIRECTORY    MetaData;
    DWORD                   Flags;
    union {
        DWORD               EntryPointToken;
        DWORD               EntryPointRVA;
    };
    IMAGE_DATA_DIRECTORY    Resources;
    IMAGE_DATA_DIRECTORY    StrongNameSignature;
    IMAGE_DATA_DIRECTORY    CodeManagerTable;
    IMAGE_DATA_DIRECTORY    VTableFixups;
    IMAGE_DATA_DIRECTORY    ExportAddressTableJumps;
    IMAGE_DATA_DIRECTORY    ManagedNativeHeader;
    
} IMAGE_COR20_HEADER;

enum {
    IMAGE_DIRECTORY_ENTRY_EXPORT,
    IMAGE_DIRECTORY_ENTRY_IMPORT,
    IMAGE_DIRECTORY_ENTRY_RESOURCE,
    IMAGE_DIRECTORY_ENTRY_EXCEPTION,
    IMAGE_DIRECTORY_ENTRY_SECURITY,
    IMAGE_DIRECTORY_ENTRY_BASERELOC,
    IMAGE_DIRECTORY_ENTRY_DEBUG,
    IMAGE_DIRECTORY_ENTRY_COPYRIGHT,
    IMAGE_DIRECTORY_ENTRY_GLOBALPTR,
    IMAGE_DIRECTORY_ENTRY_TLS,
    IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG,
    IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT,
    IMAGE_DIRECTORY_ENTRY_IAT,
    IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT,
    IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR,
    IMAGE_DIRECTORY_ENTRY_UNKNOWN
};



typedef struct {
    WORD Magic;
    BYTE MajorLinkerVersion;
    BYTE MinorLinkerVersion;
    DWORD SizeOfCode;
    DWORD SizeOfInitializedData;
    DWORD SizeOfUninitializedData;
    DWORD AddressOfEntryPoint;
    DWORD BaseOfCode;
    DWORD ImageBase;
    DWORD SectionAlignment;
    DWORD FileAlignment;
    
    WORD MajorOperatingSystemVersion;
    WORD MinorOperatingSystemVersion;
    WORD MajorImageVersion;
    WORD MinorImageVersion;
    WORD MajorSubsystemVersion;
    WORD MinorSubsystemVersion;
    
    DWORD Win32VersionValue;
    DWORD SizeOfImage;
    DWORD SizeOfHeaders;
    DWORD CheckSum;
    
    WORD Subsystem;
    WORD DllCharacteristics;
    
    DWORD SizeOfStackReserve;
    DWORD SizeOfStackCommit;
    DWORD SizeOfHeapReserve;
    DWORD SizeOfHeapCommit;
    
    DWORD LoaderFlags;
    DWORD NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY DataDirectory[16];
    
} IMAGE_OPTIONAL_HEADER;


typedef struct {
    DWORD Signature;
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER OptionalHeader;
} IMAGE_NT_HEADER;



#endif
