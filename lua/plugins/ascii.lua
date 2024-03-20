-- DO NOT FORMAT THIS FILE

local M = {}

function M.whichDay(day)
    if day == "Monday" then
        return M.monday
    elseif day == "Tuesday" then
        return M.tuesday
    end
end

function M.randomLogo()
    return M.nvim[math.random(#M.nvim)]
end

function M.randomDay(day)
    return M.days[day][math.random(#M.days[day])]
end

-- stylua: ignore

M.nvim = {
    [[
                                               88                     
                                               ""                     
                                                                      
8b,dPPYba,   ,adPPYba,  ,adPPYba,  8b       d8 88 88,dPYba,,adPYba,   
88P'   `"8a a8P_____88 a8"     "8a `8b     d8' 88 88P'   "88"    "8a  
88       88 8PP""""""" 8b       d8  `8b   d8'  88 88      88      88  
88       88 "8b,   ,aa "8a,   ,a8"   `8b,d8'   88 88      88      88  
88       88  `"Ybbd8"'  `"YbbdP"'      "8"     88 88      88      88  
    ]],
    [[
888b      88                                    88                     
8888b     88                                    ""                     
88 `8b    88                                                           
88  `8b   88  ,adPPYba,  ,adPPYba,  8b       d8 88 88,dPYba,,adPYba,   
88   `8b  88 a8P_____88 a8"     "8a `8b     d8' 88 88P'   "88"    "8a  
88    `8b 88 8PP""""""" 8b       d8  `8b   d8'  88 88      88      88  
88     `8888 "8b,   ,aa "8a,   ,a8"   `8b,d8'   88 88      88      88  
88      `888  `"Ybbd8"'  `"YbbdP"'      "8"     88 88      88      88  
    ]],
    [[
                                           ███
                                          ░░░
 ████████    ██████   ██████  █████ █████ ████  █████████████
░░███░░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███
 ░███ ░███ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███
 ░███ ░███ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███
 ████ █████░░██████ ░░██████   ░░█████    █████ █████░███ █████
░░░░ ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░
    ]],
    [[
__/\\\\\_____/\\\_______________________________/\\\________/\\\___________________________
 _\/\\\\\\___\/\\\______________________________\/\\\_______\/\\\___________________________
  _\/\\\/\\\__\/\\\______________________________\//\\\______/\\\___/\\\_____________________
   _\/\\\//\\\_\/\\\_____/\\\\\\\\______/\\\\\_____\//\\\____/\\\___\///_____/\\\\\__/\\\\\___
    _\/\\\\//\\\\/\\\___/\\\/////\\\___/\\\///\\\____\//\\\__/\\\_____/\\\__/\\\///\\\\\///\\\_
     _\/\\\_\//\\\/\\\__/\\\\\\\\\\\___/\\\__\//\\\____\//\\\/\\\_____\/\\\_\/\\\_\//\\\__\/\\\_
      _\/\\\__\//\\\\\\_\//\\///////___\//\\\__/\\\______\//\\\\\______\/\\\_\/\\\__\/\\\__\/\\\_
       _\/\\\___\//\\\\\__\//\\\\\\\\\\__\///\\\\\/________\//\\\_______\/\\\_\/\\\__\/\\\__\/\\\_
        _\///_____\/////____\//////////_____\/////___________\///________\///__\///___\///___\///__
    ]]
}

M.days = {
    Monday = {
        [[
                                                                              
88b           d88                                  88                         
888b         d888                                  88                         
88`8b       d8'88                                  88                         
88 `8b     d8' 88  ,adPPYba,  8b,dPPYba,   ,adPPYb,88 ,adPPYYba, 8b       d8  
88  `8b   d8'  88 a8"     "8a 88P'   `"8a a8"    `Y88 ""     `Y8 `8b     d8'  
88   `8b d8'   88 8b       d8 88       88 8b       88 ,adPPPPP88  `8b   d8'   
88    `888'    88 "8a,   ,a8" 88       88 "8a,   ,d88 88,    ,88   `8b,d8'    
88     `8'     88  `"YbbdP"'  88       88  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                     d8'      
                                                                    d8'       
        ]],
        [[
                                                    88                         
                                                    88                         
                                                    88                         
88,dPYba,,adPYba,   ,adPPYba,  8b,dPPYba,   ,adPPYb,88 ,adPPYYba, 8b       d8  
88P'   "88"    "8a a8"     "8a 88P'   `"8a a8"    `Y88 ""     `Y8 `8b     d8'  
88      88      88 8b       d8 88       88 8b       88 ,adPPPPP88  `8b   d8'   
88      88      88 "8a,   ,a8" 88       88 "8a,   ,d88 88,    ,88   `8b,d8'    
88      88      88  `"YbbdP"'  88       88  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                      d8'      
                                                                     d8'       
        ]],
    },
    Tuesday = {
        [[
888888888888                                      88                         
     88                                           88                         
     88                                           88                         
     88 88       88  ,adPPYba, ,adPPYba,  ,adPPYb,88 ,adPPYYba, 8b       d8  
     88 88       88 a8P_____88 I8[    "" a8"    `Y88 ""     `Y8 `8b     d8'  
     88 88       88 8PP"""""""  `"Y8ba,  8b       88 ,adPPPPP88  `8b   d8'   
     88 "8a,   ,a88 "8b,   ,aa aa    ]8I "8a,   ,d88 88,    ,88   `8b,d8'    
     88  `"YbbdP'Y8  `"Ybbd8"' `"YbbdP"'  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                    d8'      
                                                                   d8'       
        ]],
        [[
                                                  88                         
  ,d                                              88                         
  88                                              88                         
MM88MMM 88       88  ,adPPYba, ,adPPYba,  ,adPPYb,88 ,adPPYYba, 8b       d8  
  88    88       88 a8P_____88 I8[    "" a8"    `Y88 ""     `Y8 `8b     d8'  
  88    88       88 8PP"""""""  `"Y8ba,  8b       88 ,adPPPPP88  `8b   d8'   
  88,   "8a,   ,a88 "8b,   ,aa aa    ]8I "8a,   ,d88 88,    ,88   `8b,d8'    
  "Y888  `"YbbdP'Y8  `"Ybbd8"' `"YbbdP"'  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                    d8'      
                                                                   d8'       
        ]],
    },
    Wednesday = {
        [[
I8,        8        ,8I                   88                                           88                         
`8b       d8b       d8'                   88                                           88                         
 "8,     ,8"8,     ,8"                    88                                           88                         
  Y8     8P Y8     8P  ,adPPYba,  ,adPPYb,88 8b,dPPYba,   ,adPPYba, ,adPPYba,  ,adPPYb,88 ,adPPYYba, 8b       d8  
  `8b   d8' `8b   d8' a8P_____88 a8"    `Y88 88P'   `"8a a8P_____88 I8[    "" a8"    `Y88 ""     `Y8 `8b     d8'  
   `8a a8'   `8a a8'  8PP""""""" 8b       88 88       88 8PP"""""""  `"Y8ba,  8b       88 ,adPPPPP88  `8b   d8'   
    `8a8'     `8a8'   "8b,   ,aa "8a,   ,d88 88       88 "8b,   ,aa aa    ]8I "8a,   ,d88 88,    ,88   `8b,d8'    
     `8'       `8'     `"Ybbd8"'  `"8bbdP"Y8 88       88  `"Ybbd8"' `"YbbdP"'  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                                                         d8'      
                                                                                                        d8'       
        ]],
        [[
                                       88                                           88                         
                                       88                                           88                         
                                       88                                           88                         
8b      db      d8  ,adPPYba,  ,adPPYb,88 8b,dPPYba,   ,adPPYba, ,adPPYba,  ,adPPYb,88 ,adPPYYba, 8b       d8  
`8b    d88b    d8' a8P_____88 a8"    `Y88 88P'   `"8a a8P_____88 I8[    "" a8"    `Y88 ""     `Y8 `8b     d8'  
 `8b  d8'`8b  d8'  8PP""""""" 8b       88 88       88 8PP"""""""  `"Y8ba,  8b       88 ,adPPPPP88  `8b   d8'   
  `8bd8'  `8bd8'   "8b,   ,aa "8a,   ,d88 88       88 "8b,   ,aa aa    ]8I "8a,   ,d88 88,    ,88   `8b,d8'    
    YP      YP      `"Ybbd8"'  `"8bbdP"Y8 88       88  `"Ybbd8"' `"YbbdP"'  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                                                      d8'      
                                                                                                     d8'       
        ]],
    },
    Thursday = {
        [[
888888888888 88                                                    88                         
     88      88                                                    88                         
     88      88                                                    88                         
     88      88,dPPYba,  88       88 8b,dPPYba, ,adPPYba,  ,adPPYb,88 ,adPPYYba, 8b       d8  
     88      88P'    "8a 88       88 88P'   "Y8 I8[    "" a8"    `Y88 ""     `Y8 `8b     d8'  
     88      88       88 88       88 88          `"Y8ba,  8b       88 ,adPPPPP88  `8b   d8'   
     88      88       88 "8a,   ,a88 88         aa    ]8I "8a,   ,d88 88,    ,88   `8b,d8'    
     88      88       88  `"YbbdP'Y8 88         `"YbbdP"'  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                                     d8'      
                                                                                    d8'       
        ]],
        [[
        88                                                    88                         
  ,d    88                                                    88                         
  88    88                                                    88                         
MM88MMM 88,dPPYba,  88       88 8b,dPPYba, ,adPPYba,  ,adPPYb,88 ,adPPYYba, 8b       d8  
  88    88P'    "8a 88       88 88P'   "Y8 I8[    "" a8"    `Y88 ""     `Y8 `8b     d8'  
  88    88       88 88       88 88          `"Y8ba,  8b       88 ,adPPPPP88  `8b   d8'   
  88,   88       88 "8a,   ,a88 88         aa    ]8I "8a,   ,d88 88,    ,88   `8b,d8'    
  "Y888 88       88  `"YbbdP'Y8 88         `"YbbdP"'  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                                d8'      
                                                                               d8'       
        ]],
    },
    Friday = {
        [[
88888888888        88          88                         
88                 ""          88                         
88                             88                         
88aaaaa 8b,dPPYba, 88  ,adPPYb,88 ,adPPYYba, 8b       d8  
88""""" 88P'   "Y8 88 a8"    `Y88 ""     `Y8 `8b     d8'  
88      88         88 8b       88 ,adPPPPP88  `8b   d8'   
88      88         88 "8a,   ,d88 88,    ,88   `8b,d8'    
88      88         88  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                 d8'      
                                                d8'       
        ]],
        [[
   ad88            88          88                         
  d8"              ""          88                         
  88                           88                         
MM88MMM 8b,dPPYba, 88  ,adPPYb,88 ,adPPYYba, 8b       d8  
  88    88P'   "Y8 88 a8"    `Y88 ""     `Y8 `8b     d8'  
  88    88         88 8b       88 ,adPPPPP88  `8b   d8'   
  88    88         88 "8a,   ,d88 88,    ,88   `8b,d8'    
  88    88         88  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                 d8'      
                                                d8'       
        ]],
    },
    Saturday = {
        [[
 ad88888ba                                                     88                         
d8"     "8b              ,d                                    88                         
Y8,                      88                                    88                         
`Y8aaaaa,   ,adPPYYba, MM88MMM 88       88 8b,dPPYba,  ,adPPYb,88 ,adPPYYba, 8b       d8  
  `"""""8b, ""     `Y8   88    88       88 88P'   "Y8 a8"    `Y88 ""     `Y8 `8b     d8'  
        `8b ,adPPPPP88   88    88       88 88         8b       88 ,adPPPPP88  `8b   d8'   
Y8a     a8P 88,    ,88   88,   "8a,   ,a88 88         "8a,   ,d88 88,    ,88   `8b,d8'    
 "Y88888P"  `"8bbdP"Y8   "Y888  `"YbbdP'Y8 88          `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                                 d8'      
                                                                                d8'       
        ]],
        [[
                                                             88                         
                       ,d                                    88                         
                       88                                    88                         
,adPPYba, ,adPPYYba, MM88MMM 88       88 8b,dPPYba,  ,adPPYb,88 ,adPPYYba, 8b       d8  
I8[    "" ""     `Y8   88    88       88 88P'   "Y8 a8"    `Y88 ""     `Y8 `8b     d8'  
 `"Y8ba,  ,adPPPPP88   88    88       88 88         8b       88 ,adPPPPP88  `8b   d8'   
aa    ]8I 88,    ,88   88,   "8a,   ,a88 88         "8a,   ,d88 88,    ,88   `8b,d8'    
`"YbbdP"' `"8bbdP"Y8   "Y888  `"YbbdP'Y8 88          `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                                               d8'      
                                                                              d8'       
        ]],
    },
    Sunday = {
        [[
 ad88888ba                                   88                         
d8"     "8b                                  88                         
Y8,                                          88                         
`Y8aaaaa,   88       88 8b,dPPYba,   ,adPPYb,88 ,adPPYYba, 8b       d8  
  `"""""8b, 88       88 88P'   `"8a a8"    `Y88 ""     `Y8 `8b     d8'  
        `8b 88       88 88       88 8b       88 ,adPPPPP88  `8b   d8'   
Y8a     a8P "8a,   ,a88 88       88 "8a,   ,d88 88,    ,88   `8b,d8'    
 "Y88888P"   `"YbbdP'Y8 88       88  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                               d8'      
                                                              d8'       
        ]],
        [[
                                           88                         
                                           88                         
                                           88                         
,adPPYba, 88       88 8b,dPPYba,   ,adPPYb,88 ,adPPYYba, 8b       d8  
I8[    "" 88       88 88P'   `"8a a8"    `Y88 ""     `Y8 `8b     d8'  
 `"Y8ba,  88       88 88       88 8b       88 ,adPPPPP88  `8b   d8'   
aa    ]8I "8a,   ,a88 88       88 "8a,   ,d88 88,    ,88   `8b,d8'    
`"YbbdP"'  `"YbbdP'Y8 88       88  `"8bbdP"Y8 `"8bbdP"Y8     Y88'     
                                                             d8'      
                                                            d8'       
        ]],
    },
}
print(M.randomDay("Monday"))

return M
