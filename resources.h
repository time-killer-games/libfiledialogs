#include <fstream>
#include <thread>
#include <chrono>
#include <string>
#include <cstdio>

#include <windows.h>

#define IDB_EMBEDICO 1
#define IDB_FLICENSE 2
#define IDB_FONTS000 3
#define IDB_FONTS001 4
#define IDB_FONTS002 5
#define IDB_FONTS003 6
#define IDB_FONTS004 7
#define IDB_FONTS005 8
#define IDB_FONTS006 9
#define IDB_FONTS007 10
#define IDB_FONTS008 11
#define IDB_FONTS009 12
#define IDB_FONTS010 13
#define IDB_FONTS011 14
#define IDB_FONTS012 15
#define IDB_FONTS013 16
#define IDB_FONTS014 17
#define IDB_FONTS015 18
#define IDB_FONTS016 19
#define IDB_FONTS017 20
#define IDB_FONTS018 21
#define IDB_FONTS019 22
#define IDB_FONTS020 23
#define IDB_FONTS021 24
#define IDB_FONTS022 25
#define IDB_FONTS023 26
#define IDB_FONTS024 27
#define IDB_FONTS025 28
#define IDB_FONTS026 29
#define IDB_FONTS027 30
#define IDB_FONTS028 31
#define IDB_FONTS029 32
#define IDB_FONTS030 33
#define IDB_FONTS031 34
#define IDB_FONTS032 35
#define IDB_FONTS033 36
#define IDB_FONTS034 37
#define IDB_FONTS035 38
#define IDB_FONTS036 39
#define IDB_FONTS037 40
#define IDB_FONTS038 41
#define IDB_FONTS039 42
#define IDB_FONTS040 43
#define IDB_FONTS041 44
#define IDB_FONTS042 45
#define IDB_FONTS043 46
#define IDB_FONTS044 47
#define IDB_FONTS045 48
#define IDB_FONTS046 49
#define IDB_FONTS047 50
#define IDB_FONTS048 51
#define IDB_FONTS049 52
#define IDB_FONTS050 53
#define IDB_FONTS051 54
#define IDB_FONTS052 55
#define IDB_FONTS053 56
#define IDB_FONTS054 57
#define IDB_FONTS055 58
#define IDB_FONTS056 59
#define IDB_FONTS057 60
#define IDB_FONTS058 61
#define IDB_FONTS059 62
#define IDB_FONTS060 63
#define IDB_FONTS061 64
#define IDB_FONTS062 65
#define IDB_FONTS063 66
#define IDB_FONTS064 67
#define IDB_FONTS065 68
#define IDB_FONTS066 69
#define IDB_FONTS067 70
#define IDB_FONTS068 71
#define IDB_FONTS069 72
#define IDB_FONTS070 73
#define IDB_FONTS071 74
#define IDB_FONTS072 75
#define IDB_FONTS073 76
#define IDB_FONTS074 77
#define IDB_FONTS075 78
#define IDB_FONTS076 79
#define IDB_FONTS077 80
#define IDB_FONTS078 81
#define IDB_FONTS079 82
#define IDB_FONTS080 83
#define IDB_FONTS081 84
#define IDB_FONTS082 85
#define IDB_FONTS083 86
#define IDB_FONTS084 87
#define IDB_FONTS085 88
#define IDB_FONTS086 89
#define IDB_FONTS087 90
#define IDB_FONTS088 91
#define IDB_FONTS089 92
#define IDB_FONTS090 93
#define IDB_FONTS091 94
#define IDB_FONTS092 95
#define IDB_FONTS093 96
#define IDB_FONTS094 97
#define IDB_FONTS095 98
#define IDB_FONTS096 99
#define IDB_FONTS097 100
#define IDB_FONTS098 101
#define IDB_FONTS099 102
#define IDB_FONTS100 103
#define IDB_FONTS101 104
#define IDB_FONTS102 105
#define IDB_FONTS103 106
#define IDB_FONTS104 107
#define IDB_FONTS105 108
#define IDB_FONTS106 109
#define IDB_FONTS107 110
#define IDB_FONTS108 111
#define IDB_FONTS109 112
#define IDB_FONTS110 113
#define IDB_FONTS111 114
#define IDB_FONTS112 115
#define IDB_FONTS113 116
#define IDB_FONTS114 117
#define IDB_FONTS115 118
#define IDB_FONTS116 119
#define IDB_FONTS117 120
#define IDB_FONTS118 121
#define IDB_FONTS119 122
#define IDB_FONTS120 123
#define IDB_FONTS121 124
#define IDB_FONTS122 125
#define IDB_FONTS123 126
#define IDB_FONTS124 127
#define IDB_FONTS125 128
#define IDB_FONTS126 129
#define IDB_FONTS127 130
#define IDB_FONTS128 131
#define IDB_FONTS129 132
#define IDB_FONTS130 133
#define IDB_FONTS131 134
#define IDB_FONTS132 135
#define IDB_FONTS133 136
#define IDB_FONTS134 137
#define IDB_FONTS135 138
#define IDB_FONTS136 139
#define IDB_FONTS137 140
#define IDB_FONTS138 141
#define IDB_FONTS139 142
#define IDB_FONTS140 143
#define IDB_FONTS141 144
#define IDB_FONTS142 145
#define IDB_FONTS143 146
#define IDB_FONTS144 147
#define IDB_FONTS145 148
#define IDB_FONTS146 149
#define IDB_FONTS147 150
#define IDB_FONTS148 151
#define IDB_FONTS149 152
#define IDB_FONTS150 153
#define IDB_FONTS151 154
#define IDB_FONTS152 155
#define IDB_FONTS153 156
#define IDB_FONTS154 157
#define IDB_FONTS155 158
#define IDB_FONTS156 159
#define IDB_FONTS157 160

namespace {
  HRSRC        res[159];
  HGLOBAL      glb[159];
  DWORD        siz[159];
  void        *buf[159];
  std::string  pth[159] = {
    "filedialogs\\fonts\\LICENSE"
    "filedialogs\\fonts\\000-notosans-regular.ttf",
    "filedialogs\\fonts\\001-notokufiarabic-regular.ttf",
    "filedialogs\\fonts\\002-notomusic-regular.ttf",
    "filedialogs\\fonts\\003-notonaskharabic-regular.ttf",
    "filedialogs\\fonts\\004-notonaskharabicui-regular.ttf",
    "filedialogs\\fonts\\005-notonastaliqurdu-regular.ttf",
    "filedialogs\\fonts\\006-notosansadlam-regular.ttf",
    "filedialogs\\fonts\\007-notosansadlamunjoined-regular.ttf",
    "filedialogs\\fonts\\008-notosansanatolianhieroglyphs-regular.ttf",
    "filedialogs\\fonts\\009-notosansarabic-regular.ttf",
    "filedialogs\\fonts\\010-notosansarabicui-regular.ttf",
    "filedialogs\\fonts\\011-notosansarmenian-regular.ttf",
    "filedialogs\\fonts\\012-notosansavestan-regular.ttf",
    "filedialogs\\fonts\\013-notosansbamum-regular.ttf",
    "filedialogs\\fonts\\014-notosansbassavah-regular.ttf",
    "filedialogs\\fonts\\015-notosansbatak-regular.ttf",
    "filedialogs\\fonts\\016-notosansbengali-regular.ttf",
    "filedialogs\\fonts\\017-notosansbengaliui-regular.ttf",
    "filedialogs\\fonts\\018-notosansbhaiksuki-regular.ttf",
    "filedialogs\\fonts\\019-notosansbrahmi-regular.ttf",
    "filedialogs\\fonts\\020-notosansbuginese-regular.ttf",
    "filedialogs\\fonts\\021-notosansbuhid-regular.ttf",
    "filedialogs\\fonts\\022-notosanscanadianaboriginal-regular.ttf",
    "filedialogs\\fonts\\023-notosanscarian-regular.ttf",
    "filedialogs\\fonts\\024-notosanscaucasianalbanian-regular.ttf",
    "filedialogs\\fonts\\025-notosanschakma-regular.ttf",
    "filedialogs\\fonts\\026-notosanscham-regular.ttf",
    "filedialogs\\fonts\\027-notosanscherokee-regular.ttf",
    "filedialogs\\fonts\\028-notosanscoptic-regular.ttf",
    "filedialogs\\fonts\\029-notosanscuneiform-regular.ttf",
    "filedialogs\\fonts\\030-notosanscypriot-regular.ttf",
    "filedialogs\\fonts\\031-notosansdeseret-regular.ttf",
    "filedialogs\\fonts\\032-notosansdevanagari-regular.ttf",
    "filedialogs\\fonts\\033-notosansdevanagariui-regular.ttf",
    "filedialogs\\fonts\\034-notosansdisplay-regular.ttf",
    "filedialogs\\fonts\\035-notosansduployan-regular.ttf",
    "filedialogs\\fonts\\036-notosansegyptianhieroglyphs-regular.ttf",
    "filedialogs\\fonts\\037-notosanselbasan-regular.ttf",
    "filedialogs\\fonts\\038-notosansethiopic-regular.ttf",
    "filedialogs\\fonts\\039-notosansgeorgian-regular.ttf",
    "filedialogs\\fonts\\040-notosansglagolitic-regular.ttf",
    "filedialogs\\fonts\\041-notosansgothic-regular.ttf",
    "filedialogs\\fonts\\042-notosansgrantha-regular.ttf",
    "filedialogs\\fonts\\043-notosansgujarati-regular.ttf",
    "filedialogs\\fonts\\044-notosansgujaratiui-regular.ttf",
    "filedialogs\\fonts\\045-notosansgurmukhi-regular.ttf",
    "filedialogs\\fonts\\046-notosansgurmukhiui-regular.ttf",
    "filedialogs\\fonts\\047-notosanshanifirohingya-regular.ttf",
    "filedialogs\\fonts\\048-notosanshanunoo-regular.ttf",
    "filedialogs\\fonts\\049-notosanshatran-regular.ttf",
    "filedialogs\\fonts\\050-notosanshebrew-regular.ttf",
    "filedialogs\\fonts\\051-notosansimperialaramaic-regular.ttf",
    "filedialogs\\fonts\\052-notosansindicsiyaqnumbers-regular.ttf",
    "filedialogs\\fonts\\053-notosansinscriptionalpahlavi-regular.ttf",
    "filedialogs\\fonts\\054-notosansinscriptionalparthian-regular.ttf",
    "filedialogs\\fonts\\055-notosansjavanese-regular.ttf",
    "filedialogs\\fonts\\056-notosanskaithi-regular.ttf",
    "filedialogs\\fonts\\057-notosanskannada-regular.ttf",
    "filedialogs\\fonts\\058-notosanskannadaui-regular.ttf",
    "filedialogs\\fonts\\059-notosanskayahli-regular.ttf",
    "filedialogs\\fonts\\060-notosanskharoshthi-regular.ttf",
    "filedialogs\\fonts\\061-notosanskhmer-regular.ttf",
    "filedialogs\\fonts\\062-notosanskhmerui-regular.ttf",
    "filedialogs\\fonts\\063-notosanskhojki-regular.ttf",
    "filedialogs\\fonts\\064-notosanskhudawadi-regular.ttf",
    "filedialogs\\fonts\\065-notosanslao-regular.ttf",
    "filedialogs\\fonts\\066-notosanslaoui-regular.ttf",
    "filedialogs\\fonts\\067-notosanslepcha-regular.ttf",
    "filedialogs\\fonts\\068-notosanslimbu-regular.ttf",
    "filedialogs\\fonts\\069-notosanslineara-regular.ttf",
    "filedialogs\\fonts\\070-notosanslinearb-regular.ttf",
    "filedialogs\\fonts\\071-notosanslisu-regular.ttf",
    "filedialogs\\fonts\\072-notosanslycian-regular.ttf",
    "filedialogs\\fonts\\073-notosanslydian-regular.ttf",
    "filedialogs\\fonts\\074-notosansmahajani-regular.ttf",
    "filedialogs\\fonts\\075-notosansmalayalam-regular.ttf",
    "filedialogs\\fonts\\076-notosansmalayalamui-regular.ttf",
    "filedialogs\\fonts\\077-notosansmandaic-regular.ttf",
    "filedialogs\\fonts\\078-notosansmanichaean-regular.ttf",
    "filedialogs\\fonts\\079-notosansmarchen-regular.ttf",
    "filedialogs\\fonts\\080-notosansmath-regular.ttf",
    "filedialogs\\fonts\\081-notosansmayannumerals-regular.ttf",
    "filedialogs\\fonts\\082-notosansmeeteimayek-regular.ttf",
    "filedialogs\\fonts\\083-notosansmendekikakui-regular.ttf",
    "filedialogs\\fonts\\084-notosansmeroitic-regular.ttf",
    "filedialogs\\fonts\\085-notosansmiao-regular.ttf",
    "filedialogs\\fonts\\086-notosansmodi-regular.ttf",
    "filedialogs\\fonts\\087-notosansmongolian-regular.ttf",
    "filedialogs\\fonts\\088-notosansmono-regular.ttf",
    "filedialogs\\fonts\\089-notosansmro-regular.ttf",
    "filedialogs\\fonts\\090-notosansmultani-regular.ttf",
    "filedialogs\\fonts\\091-notosansmyanmar-regular.ttf",
    "filedialogs\\fonts\\092-notosansmyanmarui-regular.ttf",
    "filedialogs\\fonts\\093-notosansnabataean-regular.ttf",
    "filedialogs\\fonts\\094-notosansnewa-regular.ttf",
    "filedialogs\\fonts\\095-notosansnewtailue-regular.ttf",
    "filedialogs\\fonts\\096-notosansnko-regular.ttf",
    "filedialogs\\fonts\\097-notosansogham-regular.ttf",
    "filedialogs\\fonts\\098-notosansolchiki-regular.ttf",
    "filedialogs\\fonts\\099-notosansoldhungarian-regular.ttf",
    "filedialogs\\fonts\\100-notosansolditalic-regular.ttf",
    "filedialogs\\fonts\\101-notosansoldnortharabian-regular.ttf",
    "filedialogs\\fonts\\102-notosansoldpermic-regular.ttf",
    "filedialogs\\fonts\\103-notosansoldpersian-regular.ttf",
    "filedialogs\\fonts\\104-notosansoldsogdian-regular.ttf",
    "filedialogs\\fonts\\105-notosansoldsoutharabian-regular.ttf",
    "filedialogs\\fonts\\106-notosansoldturkic-regular.ttf",
    "filedialogs\\fonts\\107-notosansoriya-regular.ttf",
    "filedialogs\\fonts\\108-notosansoriyaui-regular.ttf",
    "filedialogs\\fonts\\109-notosansosage-regular.ttf",
    "filedialogs\\fonts\\110-notosansosmanya-regular.ttf",
    "filedialogs\\fonts\\111-notosanspahawhhmong-regular.ttf",
    "filedialogs\\fonts\\112-notosanspalmyrene-regular.ttf",
    "filedialogs\\fonts\\113-notosanspaucinhau-regular.ttf",
    "filedialogs\\fonts\\114-notosansphagspa-regular.ttf",
    "filedialogs\\fonts\\115-notosansphoenician-regular.ttf",
    "filedialogs\\fonts\\116-notosanspsalterpahlavi-regular.ttf",
    "filedialogs\\fonts\\117-notosansrejang-regular.ttf",
    "filedialogs\\fonts\\118-notosansrunic-regular.ttf",
    "filedialogs\\fonts\\119-notosanssamaritan-regular.ttf",
    "filedialogs\\fonts\\120-notosanssaurashtra-regular.ttf",
    "filedialogs\\fonts\\121-notosanssharada-regular.ttf",
    "filedialogs\\fonts\\122-notosansshavian-regular.ttf",
    "filedialogs\\fonts\\123-notosanssiddham-regular.ttf",
    "filedialogs\\fonts\\124-notosanssinhala-regular.ttf",
    "filedialogs\\fonts\\125-notosanssinhalaui-regular.ttf",
    "filedialogs\\fonts\\126-notosanssorasompeng-regular.ttf",
    "filedialogs\\fonts\\127-notosanssundanese-regular.ttf",
    "filedialogs\\fonts\\128-notosanssylotinagri-regular.ttf",
    "filedialogs\\fonts\\129-notosanssymbols2-regular.ttf",
    "filedialogs\\fonts\\130-notosanssymbols-regular.ttf",
    "filedialogs\\fonts\\131-notosanssyriac-regular.ttf",
    "filedialogs\\fonts\\132-notosanstagalog-regular.ttf",
    "filedialogs\\fonts\\133-notosanstagbanwa-regular.ttf",
    "filedialogs\\fonts\\134-notosanstaile-regular.ttf",
    "filedialogs\\fonts\\135-notosanstaitham-regular.ttf",
    "filedialogs\\fonts\\136-notosanstaiviet-regular.ttf",
    "filedialogs\\fonts\\137-notosanstakri-regular.ttf",
    "filedialogs\\fonts\\138-notosanstamil-regular.ttf",
    "filedialogs\\fonts\\139-notosanstamilsupplement-regular.ttf",
    "filedialogs\\fonts\\140-notosanstamilui-regular.ttf",
    "filedialogs\\fonts\\141-notosanstelugu-regular.ttf",
    "filedialogs\\fonts\\142-notosansteluguui-regular.ttf",
    "filedialogs\\fonts\\143-notosansthaana-regular.ttf",
    "filedialogs\\fonts\\144-notosansthai-regular.ttf",
    "filedialogs\\fonts\\145-notosansthaiui-regular.ttf",
    "filedialogs\\fonts\\146-notosanstibetan-regular.ttf",
    "filedialogs\\fonts\\147-notosanstifinagh-regular.ttf",
    "filedialogs\\fonts\\148-notosanstirhuta-regular.ttf",
    "filedialogs\\fonts\\149-notosansugaritic-regular.ttf",
    "filedialogs\\fonts\\150-notosansvai-regular.ttf",
    "filedialogs\\fonts\\151-notosanswarangciti-regular.ttf",
    "filedialogs\\fonts\\152-notosansyi-regular.ttf",
    "filedialogs\\fonts\\153-notosanstc-regular.otf",
    "filedialogs\\fonts\\154-notosansjp-regular.otf",
    "filedialogs\\fonts\\155-notosanskr-regular.otf",
    "filedialogs\\fonts\\156-notosanssc-regular.otf",
    "filedialogs\\fonts\\157-notosanshk-regular.otf"
  };
  
  inline void resources_init() {
    CreateDirectoryA("C:\\Windows\\Temp\\filedialogs", nullptr);
    CreateDirectoryA("C:\\Windows\\Temp\\filedialogs\\fonts", nullptr);
    for (int i = 0; i < 159; i++) {
      res[i] = FindResource(nullptr, MAKEINTRESOURCE(i + 1), RT_RCDATA);
      if (!res[i]) return;
      glb[i]  = LoadResource(nullptr, res[i]);
      if (!glb[i]) return;
      siz[i]  = SizeofResource(nullptr, res[i]);
      if (!siz) return;
      buf[i]  = LockResource(glb[i]);
      if (!buf[i]) return;
      std::ofstream outfile(("C:\\Windows\\Temp\\" + pth[i]).c_str(), std::ios::binary);
      if (!outfile.is_open()) return;
      outfile.write((char *)buf[i], siz[i]);
      outfile.close();
    }
  }
}
