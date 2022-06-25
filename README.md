# unfriendme_drugs
 
Configurable drugs system by me for ESX Legacy.

# Configuration
```lua
ExampleDrug2 = {
    Draw3dText = ,
    DrawMarker = ,
    Marker = ,
    Color = {r = , g = , b = , a = },
    MarkerSize = {x = , y = , z = },
    Collect = vector3(),
    CollectText = '',
    Process = vector3(),
    ProcessText = '',
    Item = '',
    ProcessedItem = '',
    EnableTeleport = ,
    Enter = vector3(),
    EnterHeading = ,
    Exit = vector3(),
    ExitHeading = ,
    PlayAnim = ,
    AnimName = ''
    }
```

You can add as much as drugs by adding new drug in Config.Drugs and putting comma under last drug

# Load Sql
```sql
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('weed', 'Raw Weed', 1, 0, 1),
	('processed_weed', 'Weed', 1, 0, 1);
```

# Help

You can contact me on discord unfriendme#3463 for any help related to this.

# Info 

This may have some bugs, you can open issue anytime so I can get to know what is needed to be changed.
