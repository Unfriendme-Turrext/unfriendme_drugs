Config = {}



Config.Drugs = {
    Weed = {
        Draw3dText = true,
        DrawMarker = true,
        Marker = 1,
        Color = {r = 100, g = 100, b = 100, a = 100},
        MarkerSize = {x = 3.0, y = 3.0, z = 0.3},
        Collect = vector3(1057.9015, -3194.7842, -39.1613),
        CollectText = 'Press ~b~[E] ~w~to Collect ~g~Weed',
        Process = vector3(1039.2406, -3205.3877, -38.1665),
        ProcessText = 'Press ~b~[E] ~w~to Process ~g~Weed',
        Item = 'weed',
        ProcessedItem = 'processed_weed',
        EnableTeleport = true,
        Enter = vector3(1066.4044, -3183.3931, -39.1638),
        EnterHeading = 79.4184,
        Exit = vector3(379.1750, -1811.8920, 29.0453),
        ExitHeading = 130.4102
    } -- You can add as much as drugs by putting comma here
    -- ExampleDrug2 = {
    --     Draw3dText = ,
    --     DrawMarker = ,
    --     Marker = ,
    --     Color = {r = , g = , b = , a = },
    --     MarkerSize = {x = , y = , z = },
    --     Collect = vector3(),
    --     CollectText = '',
    --     Process = vector3(),
    --     ProcessText = '',
    --     Item = '',
    --     ProcessedItem = '',
    --     EnableTeleport = ,
    --     Enter = vector3(),
    --     EnterHeading = ,
    --     Exit = vector3(),
    --     ExitHeading = 
    -- }

}

Config.Blips = {
    Blip1 = {
        Show = true,    
        Blip = 469,
        Size = 0.8,
        Color = 2,
        Pos = vector3(379.1750, -1811.8920, 29.0453),
        Name = 'Weed Labs'
    }
}