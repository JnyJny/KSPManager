//
//  KSP_Paths.h
//  KSPManager
//
//  Created by Erik O'Shaughnessy on 8/15/12.
//  Copyright (c) 2012 Symbolic Armageddon. All rights reserved.
//

#ifndef KSPManager_KSP_Paths_h
#define KSPManager_KSP_Paths_h

#define kKSP_DEFAULT_INSTALLATION_KEY @"kspDefaultInstallationPath"

#define kKSP_BUNDLE_ID @"unity.Squad.Kerbal Space Program"

#define kKSP_OSX   @"KSP_osx"
#define kKSP_SHORT @"KSP"
#define kKSP_LONG  @"Kerbal Space Program"

#define kKSP_DEFAULT_UNZIP_PATH @"/usr/bin/unzip"

#define kKSP_TEMP_ASSETS @"KSPTempAssets"

#define kKSP_INTERNALS   @"Internals"
#define kKSP_APP         @"KSP.app"
#define kKSP_PARTS       @"Parts"
#define kKSP_PLUGINS     @"Plugins"
#define kKSP_PLUGINDATA  @"PluginData"
#define kKSP_RESOURCES   @"Resources"
#define kKSP_SCREENSHOTS @"Screenshots"
#define kKSP_SOUNDS      @"sounds"
#define kKSP_SAVES       @"saves"
#define kKSP_PERSISTENT  @"saves/default/persistent.sfs"
#define kKSP_SETTINGS    @"settings.cfg"
#define kKSP_SHIPS       @"Ships"
#define kKSP_VAB         @"Ships/VAB"
#define kKSP_SPH         @"Ships/SPH"

#define kKSP_MODS         @"Mods"
#define kKSP_MODS_PARTS   @"Mods/Parts"
#define kKSP_MODS_PLUGINS @"Mods/Plugins"
#define kKSP_MODS_SHIPS   @"Mods/Ships"


#define kKSP_COMMENT_TOKEN    @"//"
#define kKSP_ASSIGNMENT_TOKEN @"="

// Part constants
#define kPART_CONFIG     @"part.cfg"
#define kPART_PROPULSION @"Propulsion"
#define kPART_COMMAND    @"Cmd & Ctrl"
#define kPART_STRUCTURAL @"Structural"
#define kPART_UTILITY    @"Utility"
#define kPART_DECAL      @"Decal"
#define kPART_CREW       @"Crew"

#define kPART_NAME_KEY         @"name"
#define kPART_TITLE_KEY        @"title"
#define kPART_MODULE_KEY       @"module"
#define kPART_AUTHOR_KEY       @"author"
#define kPART_DESCRIPTION_KEY  @"description"
#define kPART_CATEGORY_KEY     @"category"
#define kPART_MANUFACTURER_KEY @"manufacturer"
#define kPART_FUEL_KEY         @"fuel"
#define kPART_INTERNALFUEL_KEY @"internal_fuel"

#define kPLUGIN_EXT            @"dll"

// persistent.sfs parameter names

// Crew
#define kCrewKeyName         @"name"
#define kCrewKeyBrave        @"brave"
#define kCrewKeyDumb         @"dumb"
#define kCrewKeyBadAzz       @"badS"
#define kCrewKeyState        @"state"
#define kCrewKeyTimeOfDeath  @"ToD"
#define kCrewKeyIdx          @"idx"

typedef enum {
    kCrewStateAvailable,
    kCrewStateAssigned,
    kCrewStateDead,
    kCrewStateRewspawning
} CrewState;


// Vessel
#define kVesselKeyPid                @"pid"
#define kVesselKeyName               @"name"
#define kVesselKeySituation          @"sit"
#define kVesselKeyLanded             @"landed"
#define kVesselKeyLandedAt           @"landedAt"
#define kVesselKeySplashed           @"splashed"
#define kVesselKeyMissionElapsedTime @"met"
#define kVesselKeyLCT                @"lct"
#define kVesselKeyRoot               @"root"
#define kVesselKeyLatitude           @"lat"
#define kVesselKeyLongitude          @"lon"
#define kVesselKeyAltitude           @"alt"
#define kVesselKeyHeightAboveGround  @"hgt"
#define kVesselKeyNRM                @"nrm"
#define kVesselKeyROT                @"rot"
#define kVesselKeyCenterOfMass       @"CoM"
#define kVesselKeyStage              @"istg"
#define kVesselKeyPRST               @"prst"
#define kVesselKeyEVA                @"eva"

// Orbit

#define kOrbitKeySemiMajorAxis            @"SMA"
#define kOrbitKeyEccentricity             @"ECC"
#define kOrbitKeyInclination              @"INC"
#define kOrbitKeyLongitudeOfPeriapsis     @"LPE"
#define kOrbitKeyLongitudeOfAscendingNode @"LAN"
#define kOrbitKeyMeanAnomalyAtEpoch       @"MNA"
#define kOrbitKeyEpoch                    @"EPH"
#define kOrbitKeyReferenceBody            @"REF"
#define kOrbitKeyObjectType               @"OBJ"

enum {
    kReferenceBodyKerbol,
    kReferenceBodyKerbin,
    kReferenceBodyMun,
    kReferenceBodyMinmus,
    // add more reference bodies before here
    kReferenceBodyCount
} ;

enum {
    kOrbitObjectTypePilotable,
    kOrbitObjectTypeDebris
};

// Vessel.Orbit Keypaths

#define kVesselOrbitKeySemiMajorAxis            @"orbit." kOrbitKeySemiMajorAxis
#define kVesselOrbitKeyEccentricity             @"orbit." kOrbitKeyEccentricity
#define kVesselOrbitKeyInclination              @"orbit." kOrbitKeyInclination
#define kVesselOrbitKeyLongitudeOfPeriapsis     @"orbit." kOrbitKeyLongitudeOfPeriapsis
#define kVesselOrbitKeyLongitudeOfAscendingNode @"orbit." kOrbitKeyLongitudeOfAscendingNode
#define kVesselOrbitKeyMeanAnomalyAtEpoch       @"orbit." kOrbitKeyMeanAnomalyAtEpoch
#define kVesselOrbitKeyReferenceBody            @"orbit." kOrbitKeyReferenceBody
#define kVesselOrbitKeyReferenceBodyName        @"orbit.referenceBodyName"
#define kVesselOrbitKeyObjectType               @"orbit." kOrbitKeyObjectType

// VesselPart Keypaths
//
// Documention needed.

#define kVesselPartKeyName        @"name"
#define kVesselPartKeyUID         @"uid"
#define kVesselPartKeyParent      @"parent"
#define kVesselPartKeyPosition    @"position"
#define kVesselPartKeyRotation    @"rotation"
#define kVesselPartKeyMirror      @"mirror"
#define kVesselPartKeyISTG        @"istg"
#define kVesselPartKeyDSTG        @"dstg"
#define kVesselPartKeySQOR        @"sqor"
#define kVesselPartKeySIDX        @"sidx"
#define kVesselPartKeyAttm        @"attm"
#define kVesselPartKeySrfN        @"srfN"
#define kVesselPartKeyAttN        @"attN"
#define kVesselPartKeyMass        @"mass"
#define kVesselPartKeyTemperature @"temp"
#define kVesselPartKeyEXPT        @"expt"
#define kVesselPartKeyState       @"state"
#define kVesselPartKeyConnected   @"connected"
#define kVesselPartKeyAttached    @"attached"
#define kVesselPartKeyHasShroud   @"hasShroud"
#define kVesselPartKeyNTime       @"nTime"
#define kVesselPartKeyASpeed      @"aSpeed"
#define kVesselPartKeyQTY         @"qty"
#define kVesselPartKeySymmetry    @"sym"
#define kVesselPartKeyCData       @"cData"

#endif
