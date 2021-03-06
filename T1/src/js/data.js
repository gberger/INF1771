(function(window){
  window.data = {
    "aliases": {
      "start":  [{"x": 24, "y": 27, "z": 0}],
      "door01": [{"x": 5,  "y": 32, "z": 0}],
      "obj1":   [{"x": 13, "y": 3,  "z": 1}],
      "door10": [{"x": 14, "y": 26, "z": 1}],
      "door02": [{"x": 39, "y": 17, "z": 0}],
      "obj2":   [{"x": 13, "y": 2,  "z": 2}],
      "door20": [{"x": 13, "y": 25, "z": 2}],
      "door03": [{"x": 24, "y": 1,  "z": 0}],
      "obj3":   [{"x": 15, "y": 19, "z": 3}],
      "door30": [{"x": 14, "y": 25, "z": 3}],
      "sword":  [{"x": 6,  "y": 5,  "z": 0}],
      "dungeon1": ["door01", "door10", "obj1", "door10", "door01"],
      "dungeon2": ["door02", "door20", "obj2", "door20", "door02"],
      "dungeon3": ["door03", "door30", "obj3", "door30", "door03"]
    },
    "solutions": [
      ["start", "dungeon1", "dungeon2", "dungeon3", "sword"],
      ["start", "dungeon1", "dungeon3", "dungeon2", "sword"],
      ["start", "dungeon2", "dungeon1", "dungeon3", "sword"],
      ["start", "dungeon2", "dungeon3", "dungeon1", "sword"],
      ["start", "dungeon3", "dungeon1", "dungeon2", "sword"],
      ["start", "dungeon3", "dungeon2", "dungeon1", "sword"]
    ],
    "terrainTypes" : {
      "F": 100,
      "G": 10,
      "S": 20,
      "M": 150,
      "W": 180,
      "D": null,
      "L": 10
    },
    "maps": [
      [
        "FFFFFFFFFFFFFFFMMMMMMMMMMMMMMMMMMMMMMMMMMM",
        "FGGFGFGFGGGGGGGMMMMMMMSSSSSMMMMMMSSSSMMMMM",
        "FGGFGGGFGFGGGGGGMMMMMSSSSSSSMMMMSSSSSSMMMM",
        "FGFFGFGFGFGGFGGGGMSSSSSSSSSSSSSSSSSSSSSSMM",
        "FGGGGFGFGFGGFGGGGMSMMSSSSSSSMMMMSSSSSSMMMM",
        "FGFFGFGFGFGFFFGGGMSMMMSSSSSMMMMWMSSSSMWMMM",
        "FGFFGFGGGFGGGGGGGMSMMMMMMMMMMMMWMMMMMMWMMM",
        "FGFFFFGFFFGGGGGGGMSMMMMMMMMMMMMWMMMMMMWMGM",
        "FGGFGGGGGFGGWGGGGMSSSSSSSSSSSMMWMMMMMMWMGM",
        "FFFFGFFFGGGWWWGGGMSMMMMMSMMMSMMWMMMMMMWMGM",
        "FGGFGGGGGGWWWWWGGMMMFFFMMMFFFFFWGGMMGGWGGM",
        "FGGFGGFGGGGWWWGGGGGGGGGGGGGGGGWWWWWWWWWGGM",
        "FGGFGGFGGGGGWGGGGGGGGGGGGGGGGGWGGFGGGGGFGM",
        "FGGFGGFGGGGGGGGGGFFFGGGFFFFGGGWGGGGGGFGFGM",
        "FGGGGGGGGGGGGGGGGGGGGGGGGGGGGGWGFGFGFFGFGM",
        "FGFFFFFGFFFGGGGGGGGGGGGGGGGGGGWGGGGGGGGGGM",
        "FGGGGGGGGGGGGGGGGWWWWWWWWWWGGGGGMMMMMMMMMM",
        "FGGGGGGGGWGGFGFGGWGGGGGGGGWGGGWGMSSSSSSSSM",
        "FGFGGFGGGWGGGGGGGWGFGGGGFGWWWWWGMSMSSMSSSM",
        "FGFGGFGGGWGGFGFGGGGGGGGGGGWGGGGGMSMMMMMMMM",
        "FGFGGFGGGWGGGGGGGWGGGGGGGGWGGGMGMSSSSSSSSM",
        "FGFGGFGGGWGFFFFGGWGFGGGGFGGGGGMGMSMMMMSMMM",
        "FGGGGGGGGWGGGGGGGWGGGGGGGGWGMGMGMSSSSSSSSM",
        "FGGGGGGGGGGFFFFGGWWWWGGWWWWGMGMGMMMSSMMMMM",
        "FFFFFFFGGFFFFFFFFFGGGGGGGGWGMGMGGGGGGGGGGM",
        "FFFFFFGGFFFFFGFFFFFGFFFGGGWGMGGGGGGGGGGGGM",
        "FGFGFGGGFFFFGGGFFFFGFFFGGGWGMGGGMMMMMMMMMM",
        "MGGGFGGGFFFGGGGGFFFGGGGGGGWGGGGGGGGMGGGGGM",
        "MGGGFGGGFFFFGGGFFFFGFGGGGGWGGGGGGGGMGGGGGM",
        "MGGGGGGGGFFFFGFFFFGGFGGGGGWWWGWWWWGMGMMMMM",
        "MGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGWGGGGGGGM",
        "MMMMMMMMMGGGGMMMMMMMGGMMMMGGGGGGGWMMMMMMGM",
        "MSSSSSSSMGGGGMGGGGGGGGGGGMGGGGGGGWMMMMMMMM",
        "MSMMSSSSMGGGGMGGGGGGGGFGGMGGWWWWWWWWMMWWMM",
        "MSMMSSSSMGGGGMGFGGWWGGFGGMGGWWMWWWWWMMWWMM",
        "MSSSSSSSMGGMGMGGGGWWGGFGGMGGWWWWMMWWMMWWMM",
        "MSSSSSSSMGGMGGGGGGGGGGGGGMGGWWWWMMWWMMWWMM",
        "MSSSSSSMMMMMGGFGGGGGFFFGGMGGWWWWWWWWMMWWMM",
        "MSSSSSSSSMMMGGFGWWWGGFGGGMGGWWWWWWWWMMWWMM",
        "MSSSSSSSSMMMGGFGGGGGGFGGGMGGWWWWWWWWWWWWMM",
        "MSSSSSSSSSGGGGGGGGGGGGGGGMMMWWWWWWWWWWWWMM",
        "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
      ], [
        "DDDDDDDDDDDDDDDDDDDDDDDDDDDD",
        "DLLLDDDDDDDDDDDDDDDDDLLLDDDD",
        "DLLLDDDDDDDDLLLDDDDDDLLLDDDD",
        "DDLDDDDLLLLLLLLDDDDDDLLLDDDD",
        "DDLDDDDLDDDDLLLDDDDDDDLDDDDD",
        "DDLLLLLLDDDDDDDDDDDDDDLDDDDD",
        "DDLDDDDDDDDDDDDDDDDDDDLDDDDD",
        "DDLDDDDDDDDDDDDDDDDLLLLLLLDD",
        "DDLDDDDDDDDLLLLLDDDLLLLLLLDD",
        "DDLLLLLLDDDLLLLLDDDLLLLLLLDD",
        "DDDLDDDLDDDLLLLLDDDLLLLLLLDD",
        "DDDLDDDLDDDDDLDDDDDDDDLDDDDD",
        "DDLLLDDLDDDDDLDDDDDDDDLDDDDD",
        "DDLLLDDLDDDDDLDDDDDDLLLLLDDD",
        "DDLLLDDLDDDDDLDDDDDDLDDDLDDD",
        "DDDDDDDLLLLLLLLLLLLLLDDDLDDD",
        "DDDDDDDLDDDDDDDDDDDDLDDDLDDD",
        "DDDDDDDLDDDDDDDDDDDDLDDDLDDD",
        "DDLLLDDLDDLLLDDDDDLLLLDDLDDD",
        "DDLLLLLLLLLLLDDDDDLLLLDDLDDD",
        "DDLLLDDLDDLLLDDDDDLLLLDDLDDD",
        "DDDDDDDLDDDDDDDDDDDDDDDDLDDD",
        "DDDDDDDLDDDDDDLLLLLLLLLLLDDD",
        "DDDDDDLLLLDDDDLDDDDDDDDDDDDD",
        "DDDDDDLLLLDDDDLDDDDDDDDDDDDD",
        "DDDDDDLLLLDDLLLLLDDDDDDDDDDD",
        "DDDDDDDDDDDDLLLLLDDDDDDDDDDD",
        "DDDDDDDDDDDDDDDDDDDDDDDDDDDD"
      ], [
        "DDDDDDDDDDDDDDDDDDDDDDDDDDDD",
        "DDLLLLLDDDDDLLLDDDDDDDDDDDDD",
        "DDLLLLLLLLDDLLLDDDLLLLDDDDDD",
        "DDLLLLLDDLDDLLLDDDDDDLDDDDDD",
        "DDDDLDDDDLDDDLDDDDDDDLDLLLLD",
        "DDDDLDDDDLLLLLLLLLLDDLLLLLLD",
        "DDDDLDDDDDDDDLDDDDLDDDDLLLLD",
        "DDLLLLLDDDDDDDDDDDLDDDDLLLLD",
        "DDLLLLLLLLLLLLLLLLLDDDDDDLDD",
        "DDLLLLLDDDDDDDDDDDDDDDDDDLDD",
        "DDDDLDDDDDDDDDLLLLLLLLDDDLDD",
        "DDDDLDDDDDDDDDLLLLLLLLDDDLDD",
        "DDDDLDDLLLLLDDLLLLLLLLDDDLDD",
        "DDLLLLLLLLLLLLLDDDLDDDDDDLDD",
        "DDDDDDDLLLLLDDDDDDLDDDDDDLDD",
        "DDDDLDDDDLDDDDDDLLLLLDDDDLDD",
        "DDDDLDDDDLDDDDDDLLLLLLLLLLDD",
        "DDDDLDDDDLLLLLDDLLLLLDDDDLDD",
        "DDLLLLDDDLDDDLDDDDLDDDDDDLDD",
        "DDLDDLDDDLDDDLDDDDLDDDDDDLDD",
        "DDLDDLDDLLLLLLLLLLLLLLLLLLDD",
        "DDLDDDDDDDDDDDDDDDLDDDDLDDDD",
        "DDLLLLLLDDLLLLLLLLLLLLDLDDDD",
        "DDLDDLLLDDLDDLDDDDLDDDDLDDDD",
        "DDLDDLLLDDLDDLDDDDLDDLLLLLDD",
        "DDLDDLLLLLLDLLLDDDLLLLLLLLDD",
        "DDDDDDDDDDDDLLLDDDDDDDDDDDDD",
        "DDDDDDDDDDDDDDDDDDDDDDDDDDDD"

      ], [
        "DDDDDDDDDDDDDDDDDDDDDDDDDDDD",
        "DDDDDDDDDDDDDDDDDDDDDDDDDDDD",
        "DDDDDDDDDDDDDDDDDDDDDDDDDDDD",
        "DDDLLLLLLLLLLLLLLLLLLLLLLDDD",
        "DDDLDDDDDDDDDDDLDDDDDDDDLDDD",
        "DDDLDDDDDDDDDDDLDDDDDDDDLDDD",
        "DDDLDDLLLDLLLDLLLDLLLDDDLDDD",
        "DDDLDDLLLLLLLDLLLDLLLDDDLDDD",
        "DDDLDDLLLDLLLDLLLDLLLDDDLDDD",
        "DDDLDDDDDDDLDDDLDDDLDDDDLDDD",
        "DDDLDDLLLDDLDDDLDDDLDLLDLDDD",
        "DDDLLLLLLLLLLLLLLLLLLLLDLDDD",
        "DDDLDDLLLDDLDDDDDDDLDLLDLDDD",
        "DDDLDDDLDDDLDDDDDDDLDDDDLDDD",
        "DDDLDDLLLDLLLDLLLDLLLDDDLDDD",
        "DDDLDDLLLDLLLLLLLDLLLDDDLDDD",
        "DDDLDDLLLDLLLDLLLDLLLDDDLDDD",
        "DDDLDDDLDDDDDDDLDDDDDDDDLDDD",
        "DDDLDDLLLDDDDLLLLLDDLLLDLDDD",
        "DDDLDDLLLDDDDLLLLLDDLLLDLDDD",
        "DDDLDDDDDDDDDDDDDDDDDLDDLDDD",
        "DDDLLLLLLLLLLLLLLLLLLLLLLDDD",
        "DDDDDDLDDDDDDDLDDDDDDLDDDDDD",
        "DDDDDDLDDDDDDDLDDDDDDLDDDDDD",
        "DDDDLLLLLDDDLLLLLDDLLLLLDDDD",
        "DDDDLLLLLDDDLLLLLDDLLLLLDDDD",
        "DDDDLLLLLDDDLLLLLDDLLLLLDDDD",
        "DDDDDDDDDDDDDDDDDDDDDDDDDDDD"
      ]
    ],
    "icons": [
      {"type": "door", "position": {"x": 5,  "y": 32, "z": 0}},
      {"type": "door", "position": {"x": 14, "y": 26, "z": 1}},
      {"type": "door", "position": {"x": 39, "y": 17, "z": 0}},
      {"type": "door", "position": {"x": 13, "y": 25, "z": 2}},
      {"type": "door", "position": {"x": 24, "y": 1,  "z": 0}},
      {"type": "door", "position": {"x": 14, "y": 25, "z": 3}},
      {"type": "star", "position": {"x": 13, "y": 3,  "z": 1}},
      {"type": "star", "position": {"x": 13, "y": 2,  "z": 2}},
      {"type": "star", "position": {"x": 15, "y": 19, "z": 3}},
      {"type": "star", "position": {"x": 6,  "y": 5,  "z": 0}}
    ]
  };
})(window);