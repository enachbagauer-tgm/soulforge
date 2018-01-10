local Soulforge = RegisterMod("Soulforge",1);
local BumboSoul = Isaac.GetItemIdByName ("BumBo Soul")
local FlameThrower = Isaac.GetItemIdByName ("Item1")
local AngleSoul = Isaac.GetItemIdByName ("Item2")
--ArcaneLockdown: Nachtrefferfolge auf selben gegner explodieren aus ihm (zerstört die gegner nicht) Tears(Player)
--Flamethrower: Flammenwerfer (check)
--Angle Soul:HP(ethernal Harts) pro flooor Angle Deal 


function Soulforge:CacheUpdate(player, cacheFlag)
  
  local player = Isaac.GetPlayer(0);
  local fd = Isaac.GetPlayer(0).MaxFireDelay * 4; 
  local isStatChanged = 0
  local heart = true
  
  if (cacheFlag == CacheFlag.CACHE_FIREDELAY) then 
    isStatChanged = 1 
  end
  
  if player:HasCollectible(FlameThrower) == true and isStatChanged == 1  then
    player.MaxFireDelay = player.MaxFireDelay - (fd/4)
    isStatChanged = 0
  end
  
  if player:HasCollectible(FlameThrower) == true then 
    Isaac.GetPlayer(0).TearColor = Color(255.0,93,0,1,1,0,0)
    Isaac.GetPlayer(0).Damage = 3
    Isaac.GetPlayer(0).FireDelay = fd-1
    Isaac.GetPlayer(0).TearHeight = 2
    Isaac.GetPlayer(0).TearFlags = Isaac.GetPlayer(0).TearFlags +             TearFlags.TEAR_PIERCING + TearFlags.TEAR_BURN
  end

  if player:HasCollectible(BumboSoul) == true then 
    player.Damage=player.Damage+math.random(0,1)*0.5;
    player.MoveSpeed=player.MoveSpeed+math.random(0,1)*0.5;
    player.ShotSpeed=player.ShotSpeed+math.random(0,1)*0.2;
    player.TearHeight = player.TearHeight +math.random(0,1)*0.3;
    player.Luck = player.Luck+math.random(0,1)*0.5;
end
  if Isaac.GetPlayer(0):HasCollectible(AngleSoul) and heart == true then 
   pos = Vector(Isaac.GetPlayer(0).Position.X, player.Position.Y);
   Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART,  HeartSubType.HEART_ETERNAL, pos, Vector(0, 0), Isaac.GetPlayer(0))
   heart=false
  end   
   

end

function Soulforge:Color()
    local player= Isaac.GetPlayer(0)
    if Isaac.GetPlayer(0):HasCollectible(FlameThrower) then
    Isaac.GetPlayer(0).TearColor = Color(255.0,93,0,1,1,0,0)
    end
  end
  
function Soulforge:GiveHeart()
  if Isaac.GetPlayer(0):HasCollectible(AngleSoul) == true then 
    pos = Vector(Isaac.GetPlayer(0).Position.X, Isaac 
      .Position.Y);
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART,  HeartSubType.HEART_ETERNAL, pos, Vector(0, 0), Isaac.GetPlayer(0))

  end
end

  Soulforge:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Soulforge.CacheUpdate)
  Soulforge:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Soulforge.Color)
  Soulforge:AddCallback(ModCallbacks.MC_POST_UPDATE, Soulforge.Color)
  Soulforge:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Soulforge.GiveHeart)
  