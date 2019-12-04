KaymonsCloset_debugmode = false;

KaymonsCloset_PrintFormat = "|c00f7f26c%s|r";

local KaymonsCloset_cStatCategoryInfo =
{
	{Category = "Stat", Name = KaymonsCloset_cStatsCategory},
	{Category = "Melee", Name = KaymonsCloset_cMeleeCategory},
	{Category = "Spell", Name = KaymonsCloset_cSpellsCategory},
	{Category = "Regen", Name = KaymonsCloset_cRegenCategory},
	{Category = "Resist", Name = KaymonsCloset_cResistCategory},
	{Category = "Trade", Name = KaymonsCloset_cTradeCategory},
};

KaymonsCloset_SlotInfo = {
    ["HeadSlot"] = 1,
    ["NeckSlot"] = 2, 
    ["ShoulderSlot"] = 3,
    ["BackSlot"] = 15,
    ["ChestSlot"] = 5,
    ["WristSlot"] = 9,

    ["HandsSlot"] = 10,
    ["WaistSlot"] = 6,
    ["LegsSlot"] = 7,
    ["FeetSlot"] = 8,
    ["Finger0Slot"] = 11,
    ["Finger1Slot"] = 12,
    ["Trinket0Slot"] = 13,
    ["Trinket1Slot"] = 14,
 
    ["MainHandSlot"] = 16,
    ["SecondaryHandSlot"] = 17,
    ["RangedSlot"] = 18,
    ["AmmoSlot"] = 0,
};

-- just the slots with durability
KaymonsCloset_DurabilitySlots = {
    ["HeadSlot"] = 1,
    ["ShoulderSlot"] = 3,
    ["ChestSlot"] = 5,
    ["WristSlot"] = 9,

    ["HandsSlot"] = 10,
    ["WaistSlot"] = 6,
    ["LegsSlot"] = 7,
    ["FeetSlot"] = 8,
 
    ["MainHandSlot"] = 16,
    ["SecondaryHandSlot"] = 17,
    ["RangedSlot"] = 18,
};

-- NOTE: ignoring these slots
    -- "TabardSlot"
    -- "ShirtSlot"
    -- "Bag0Slot"
    -- "Bag1Slot"
    -- "Bag2Slot"
    -- "Bag3Slot"

-- for Bindings.xml
BINDING_HEADER_KAYMONSCLOSET_PLUGINNAME = "KaymonsCloset Outfits";
BINDING_NAME_KAYMONSCLOSET_OUTFIT1  = "Outfit 1";
BINDING_NAME_KAYMONSCLOSET_OUTFIT2  = "Outfit 2";
BINDING_NAME_KAYMONSCLOSET_OUTFIT3  = "Outfit 3";
BINDING_NAME_KAYMONSCLOSET_OUTFIT4  = "Outfit 4";
BINDING_NAME_KAYMONSCLOSET_OUTFIT5  = "Outfit 5";
BINDING_NAME_KAYMONSCLOSET_OUTFIT6  = "Outfit 6";
BINDING_NAME_KAYMONSCLOSET_OUTFIT7  = "Outfit 7";
BINDING_NAME_KAYMONSCLOSET_OUTFIT8  = "Outfit 8";
BINDING_NAME_KAYMONSCLOSET_OUTFIT9  = "Outfit 9";
BINDING_NAME_KAYMONSCLOSET_OUTFIT10 = "Outfit 10";

local KaymonsCloset_cSpecialtyBags =
{
	[21340] = {Name = "Soul Pouch", Type = "ShardBag"},
	[21341] = {Name = "Felcloth Bag", Type = "ShardBag"},
	[21342] = {Name = "Core Felcloth Bag", Type = "ShardBag"},
	[22243] = {Name = "Small Soul Pouch", Type = "ShardBag"},
	[22244] = {Name = "Box of Souls", Type = "ShardBag"},
	
	[2102] = {Name = "Small Ammo Pouch", Type = "AmmoPouch"},
	[7279] = {Name = "Small Leather Ammo Pouch", Type = "AmmoPouch"},
	[8218] = {Name = "Thick Leather Ammo Pouch", Type = "AmmoPouch"},
	[7372] = {Name = "Heavy Leather Ammo Pouch", Type = "AmmoPouch"},
	[3574] = {Name = "Hunting Ammo Sack", Type = "AmmoPouch"},
	[3604] = {Name = "Bandolier of the Night Watch", Type = "AmmoPouch"},
	[5441] = {Name = "Small Shot Pouch", Type = "AmmoPouch"},
	[2663] = {Name = "Ribbly's Bandolier", Type = "AmmoPouch"},
	[19320] = {Name = "Gnoll Skin Bandolier", Type = "AmmoPouch"},

	[19319] = {Name = "Harpy Hide Quiver", Type = "Quiver"},
	[7371] = {Name = "Heavy Quiver", Type = "Quiver"},
	[3573] = {Name = "Hunting Quiver", Type = "Quiver"},
	[7278] = {Name = "Light Leather Quiver", Type = "Quiver"},
	[2101] = {Name = "Light Quiver", Type = "Quiver"},
	[11362] = {Name = "Medium Quiver", Type = "Quiver"},
	[8217] = {Name = "Quickdraw Quiver", Type = "Quiver"},
	[3605] = {Name = "Quiver of the Night Watch", Type = "Quiver"},
	[2662] = {Name = "Ribbly's Quiver", Type = "Quiver"},
	[5439] = {Name = "Small Quiver", Type = "Quiver"},
	[18714] = {Name = "Ancient Sinew Wrapped Lamina", Type = "Quiver"},
	
	[22246] = {Name = "Enchanted Mageweave Pouch", Type = "Enchant"},
	[22248] = {Name = "Enchanted Runecloth Bag", Type = "Enchant"},
	[22249] = {Name = "Big Bag of Enchantment", Type = "Enchant"},
	
	[22250] = {Name = "Herb Pouch", Type = "Herb"},
	[22251] = {Name = "Cenarian Herb Bag", Type = "Herb"},
	[22252] = {Name = "Satchel of Cenarious", Type = "Herb"},
};

KaymonsCloset_cCategoryDescriptions =
{
	Sets = KaymonsCloset_cSetsCategoryDescripton,
};

StaticPopupDialogs["KAYMONSCLOSET_CONFIRM_DELETE"] =
{
	text = KaymonsCloset_cConfirmDeleteMsg,
	button1 = DELETE,
	button2 = CANCEL,
	OnAccept = function() KaymonsCloset_DeleteSelectedOutfit(); end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

local OUTFIT_MESSAGE_COLOR = {r = 0.2, g = 0.75, b = 0.3};
local COMBAT_MESSAGE_COLOR = {r = 0.75, g = 0.2, b = 0.3};
local BANKED_FONT_COLOR = {r = 0.25, g = 0.2, b = 1.0};

local gKaymonsCloset_Initialized = false;

local gKaymonsCloset_SetToRename = nil;
local gKaymonsCloset_OutfitToDelete = nil;

local gKaymonsCloset_NeedCurrentOutfit = false;

local gKaymonsCloset_SetSwapInProgress = false;

local gKaymonsCloset_SelectedOutfit = nil;
local gKaymonsCloset_CurrentOutfit = nil;
local gKaymonsCloset_BankFrameOpened = false;

-- GUI constants
local KaymonsCloset_cMaxDisplayedItems = 14;
local gKaymonsCloset_CurrentPanel = 0;
local gKaymonsCloset_PanelFrames =
{
	"KaymonsClosetMainFrame",
	"KaymonsClosetOptionsFrame",
	"KaymonsClosetAboutFrame",
};

local gKaymonsCloset_cCategoryOrder =
{
	"Sets"
};
local gKaymonsCloset_Collapsed = {};

-- handles all incoming chat commands
SLASH_KAYMONSCLOSET1 = "/kc";
SLASH_KAYMONSCLOSET2 = "/kaymonscloset";
function SlashCmdList.KAYMONSCLOSET(args)
    words = {}
    for word in args:gmatch("%w+") do table.insert(words, word) end

    for i = 1, table.getn(words) do
        words[i] = strlower(words[i])
    end

    local name = KaymonsCloset_GetNameFromArgs(words);
    if KaymonsCloset_HasValue(words, "print") then
        if name then
            KaymonsCloset_PrintGear(name);
        else
            KaymonsCloset_Print("Specify GearSet Name");
        end
    elseif KaymonsCloset_HasValue(words, "printmissing") then
        if name then
            KaymonsCloset_PrintMissingGear(name);
        else
            KaymonsCloset_Print("Specify GearSet Name");
        end
    elseif(KaymonsCloset_HasValue(words, "reset")) then
        KaymonsCloset_Reset();
    else
        KaymonsCloset_Print("/kc options: print, printmissing, reset");
    end
end

-- register any needed events
function KaymonsCloset_OnLoad(self)
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("BANKFRAME_OPENED");
	self:RegisterEvent("BANKFRAME_CLOSED");
	self:RegisterEvent("UNIT_INVENTORY_CHANGED");
	self:RegisterEvent("BAG_UPDATE");

    PanelTemplates_SetNumTabs(self, table.getn(gKaymonsCloset_PanelFrames));
	KaymonsClosetFrame.selectedTab = gKaymonsCloset_CurrentPanel;
    PanelTemplates_UpdateTabs(self);
    
    KaymonsCloset_Print("OnLoad Success");
end

function KaymonsCloset_NewNakedOutfit()
    local set = KaymonsCloset_NewEmptyOutfit("Naked");
    for slotname, _ in pairs(KaymonsCloset_SlotInfo) do
        set.Items[slotname] = "";
	end
	for slotname, _ in pairs(KaymonsCloset_DurabilitySlots) do
        set.Items[slotname] = "nil";
    end
    return set;
end

function KaymonsCloset_InitializeOutfits()
    gKaymonsCloset_Settings.Outfits = {};
    gKaymonsCloset_Settings.Outfits["Sets"] = {};
    
	KaymonsCloset_AddOutfit(KaymonsCloset_NewNakedOutfit());
	gKaymonsCloset_NeedCurrentOutfit = true;
end

function KaymonsCloset_Initialize()
    if not gKaymonsCloset_Settings then
        gKaymonsCloset_Settings = {};
    end

    if not gKaymonsCloset_Settings.Options then
        gKaymonsCloset_Settings.Options = {};
    end

    if not gKaymonsCloset_Settings.Outfits then
		KaymonsCloset_InitializeOutfits();
	end

    if gKaymonsCloset_Settings.Options.HideMinimapButton then
		KaymonsClosetMinimapButton:Hide();
	else
		KaymonsClosetMinimapButton:Show();
    end
    
    if not gKaymonsCloset_Settings.Options.MinimapButtonAngle then
		gKaymonsCloset_Settings.Options.MinimapButtonAngle = -1.5708;
    end
    
    KaymonsClosetMinimapButton_SetPositionAngle(gKaymonsCloset_Settings.Options.MinimapButtonAngle);

	gKaymonsCloset_CurrentOutfit = KaymonsCloset_SaveCurrentGear();

    gKaymonsCloset_Initialized = true;
    DEFAULT_CHAT_FRAME:AddMessage("KaymonsCloset Initialized")
end

-- handle events
function KaymonsCloset_OnEvent(event, arg1)
    if not gKaymonsCloset_Initialized and event == "VARIABLES_LOADED" then
		KaymonsCloset_Initialize();
	elseif event == "BANKFRAME_OPENED" then
		KaymonsCloset_BankFrameOpened();
	elseif event == "BANKFRAME_CLOSED" then
		KaymonsCloset_BankFrameClosed();
	elseif event == "UNIT_INVENTORY_CHANGED" then
		KaymonsCloset_InventoryUpdate();
	elseif event == "BAG_UPDATE" then
		KaymonsCloset_BagUpdate();
    end
end

function KaymonsCloset_BagUpdate()
	KaymonsCloset_Update();
end

function KaymonsCloset_InventoryUpdate()
	local set = KaymonsCloset_SaveCurrentGear();
	gKaymonsCloset_CurrentOutfit = set;
	if gKaymonsCloset_SetSwapInProgress then
		if gKaymonsCloset_SelectedOutfit then
			local vOutfit = KaymonsCloset_GetOutfit(gKaymonsCloset_SelectedOutfit.Name);
			if vOutfit.Items == gKaymonsCloset_SelectedOutfit.Items then
				gKaymonsCloset_SetSwapInProgress = false;
				KaymonsCloset_Update(true);
			end
		end
	elseif KaymonsClosetSlotEnables:IsVisible() then
		-- single item swap
		local vOutfit = KaymonsCloset_GetOutfit(gKaymonsCloset_SelectedOutfit.Name);
		vOutfit.Items = set.Items;
	end
	KaymonsCloset_Update();
end

function KaymonsCloset_BankFrameOpened()
	gKaymonsCloset_BankFrameOpened = true;
	KaymonsCloset_Update();
end

function KaymonsCloset_BankFrameClosed()
	gKaymonsCloset_BankFrameOpened = false;
	KaymonsCloset_Update();
end

-- prints msg to console
function KaymonsCloset_Print(msg, isdebug)
    -- TODO: make this pretty
    if (KaymonsCloset_debugmode and isdebug) then
        DEFAULT_CHAT_FRAME:AddMessage(string.format(
            KaymonsCloset_PrintFormat, "KaymonsCloset Debug: " .. tostring(msg)));
    elseif(isdebug == nil or isdebug == false) then
        DEFAULT_CHAT_FRAME:AddMessage(string.format(
            KaymonsCloset_PrintFormat, "KaymonsCloset: " .. tostring(msg)));
    end
end

-- checks for a specific value in a table
function KaymonsCloset_HasValue(tab, val)
    for _, value in pairs(tab) do
        if (value == val) then
            return true;
        end
    end
    return false;
end

-- checks the 2rd element of args for a gearset name
function KaymonsCloset_GetNameFromArgs(args)
    return args[2];
end

-- returns true if item is missing otherwise false
function KaymonsCloset_IsMissing(itemlink)
    -- check containers
    for i = 0, 4 do
        for j = 1, GetContainerNumSlots(i) do
            if(GetContainerItemLink(i, j) == itemlink) then
                return false, i, j;
            end
        end
    end
    -- check inventory
    if(IsEquippedItem(itemlink)) then
        return false, 0, 0;
    end
    return true, nil, nil;
end

function KaymonsCloset_NewEmptyOutfit(pName)
	return {Name = pName, Items = {}};
end

function KaymonsCloset_CreateNewOutfit()
    local set = KaymonsCloset_SaveCurrentGear(nil);
    gKaymonsCloset_SetToRename = set;
    
    KaymonsClosetNameOutfitDialogTitle:SetText(KaymonsCloset_cNewOutfit);
	KaymonsClosetNameOutfitDialogName:SetText("");
	KaymonsClosetNameOutfitDialogNameCreateUsing:Show();
    KaymonsClosetNameOutfitDialog:SetHeight(KaymonsClosetNameOutfitDialog.baseHeight);
	
	KaymonsClosetNameOutfitDialog:Show();
	KaymonsClosetNameOutfitDialogName:SetFocus();
end

function KaymonsClosetNameOutfit_Open(pOutfit)
	gKaymonsCloset_SetToRename = pOutfit;

	if gKaymonsCloset_SetToRename then
		KaymonsClosetNameOutfitDialogTitle:SetText(KaymonsCloset_cRenameOutfit);
		KaymonsClosetNameOutfitDialogName:SetText(gKaymonsCloset_SetToRename.Name);
		KaymonsClosetNameOutfitDialogNameCreateUsing:Hide();
		KaymonsClosetNameOutfitDialog:SetHeight(KaymonsClosetNameOutfitDialog.baseHeight - 35);
	end

	KaymonsClosetNameOutfitDialog:Show();
	KaymonsClosetNameOutfitDialogName:SetFocus();
end

function KaymonsClosetNameOutfit_Cancel()
	KaymonsClosetNameOutfitDialog:Hide();
end

function KaymonsClosetNameOutfit_Done()
	local name = KaymonsClosetNameOutfitDialogName:GetText();
	if KaymonsCloset_HasGearSetName(gKaymonsCloset_SetToRename.Name) then
		KaymonsCloset_DeleteOutfit(gKaymonsCloset_SetToRename);
	end
    gKaymonsCloset_SetToRename.Name = name;
    KaymonsCloset_AddOutfit(gKaymonsCloset_SetToRename);
    gKaymonsCloset_SetToRename = nil;
    KaymonsClosetNameOutfitDialog:Hide()
	KaymonsCloset_Update();
	KaymonsCloset_Print("Created: " .. name);
end

-- builds the gearset table
function KaymonsCloset_SaveCurrentGear(pName)
    local set = KaymonsCloset_NewEmptyOutfit(pName);
    local itemlink;
    for slotname, slotid in pairs(KaymonsCloset_SlotInfo) do
        itemlink = GetInventoryItemLink("player", slotid);
        set.Items[slotname] = tostring(itemlink);
    end
    return set;
end

-- adds the gearset table to saved vars
function KaymonsCloset_AddOutfit(pOutfit)
    pOutfit.CategoryID = "Sets"
	
	if not gKaymonsCloset_Settings.Outfits then
		gKaymonsCloset_Settings.Outfits = {};
	end
	
	if not gKaymonsCloset_Settings.Outfits["Sets"] then
		gKaymonsCloset_Settings.Outfits["Sets"] = {};
	end
	
    table.insert(gKaymonsCloset_Settings.Outfits["Sets"], pOutfit);
end

function KaymonsCloset_DeleteOutfit(pOutfit)
	if pOutfit == gKaymonsCloset_SelectedOutfit then
		KaymonsCloset_ClearSelection();
	end

	local toremove;
	for index, outfit in pairs(gKaymonsCloset_Settings.Outfits["Sets"]) do
		if outfit.Name == pOutfit.Name then
			toremove = index;
			break;
		end
	end
	table.remove(gKaymonsCloset_Settings.Outfits["Sets"], toremove);
end

-- prints all items in the gearset and states if they are missing
function KaymonsCloset_PrintGear(name)
	local vOutfit = KaymonsCloset_GetOutfit(name);
    if vOutfit then
        KaymonsCloset_Print(name .. ":");
        for slotname, itemlink in pairs(vOutfit.Items) do
            -- NOTE: key is the slotname
            if itemlink ~= "nil" and itemlink ~= "" then
                KaymonsCloset_Print(slotname .. ": " .. tostring(itemlink));
            end
        end
    else
        KaymonsCloset_Print("Gearset named " .. name .. " doesn't exist");
    end
end

-- only prints missing gear in the gearset
function KaymonsCloset_PrintMissingGear(name)
    local vOutfit = KaymonsCloset_GetOutfit(name);
    if vOutfit then
        local printed = false;
        KaymonsCloset_Print(name .. ":");
        for _, itemlink in pairs(vOutfit.Items) do
            -- NOTE: key is the slotname
            if(itemlink ~= "nil" and itemlink ~= "" and KaymonsCloset_IsMissing(itemlink)) then
                KaymonsCloset_Print(itemlink .. string.format(KaymonsCloset_PrintFormat, " is missing"));
                printed = true;
            end
        end
        if(not printed) then
            KaymonsCloset_Print("nothing missing");
        end
    else
        KaymonsCloset_Print("Gearset named " .. name .. " doesn't exist");
    end
end

-- equips specified gearset
function KaymonsCloset_EquipGearSet(set)
    local bag = -1;
    local count = 0;
	local printedFull = false
	if set == nil then return end
    if not UnitAffectingCombat("player") then
        for slotname, itemlink in pairs(set.Items) do
			if itemlink == "nil" then
				if GetInventoryItemLink("player", KaymonsCloset_SlotInfo[slotname]) then
					gKaymonsCloset_SetSwapInProgress = true;
					-- slot should be empty
					if count == 0 and not printedFull then
						bag, count = KaymonsCloset_FindOpenBag(bag+1);
					end
					if(count > 0) and not printedFull then
						PickupInventoryItem(KaymonsCloset_SlotInfo[slotname]);
						if(bag == 0) then
							PutItemInBackpack();
						else
							PutItemInBag(bag+19);
						end
						count = count - 1;
					elseif not printedFull then
						KaymonsCloset_Print("Bags are full");
						printedFull = true;
					end
				end
			elseif itemlink ~= "" then
				-- equip the item
                local ismissing, i, j = KaymonsCloset_IsMissing(itemlink);
                if not ismissing then
                    if(j ~= 0) then
						gKaymonsCloset_SetSwapInProgress = true;
                        -- equip item from bags
                        PickupContainerItem(i, j);
                        local slotid = KaymonsCloset_SlotInfo[slotname];
                        EquipCursorItem(slotid);
                    end
                    -- if j == 0 then item is currenty equipped, continue
                else
                    KaymonsCloset_Print(itemlink .. string.format(KaymonsCloset_PrintFormat, " is missing"));
                end
            end
		end
		gKaymonsCloset_SelectedOutfit = set;
		UIErrorsFrame:AddMessage(format(KaymonsCloset_cEquipOutfitMessageFormat, set.Name), OUTFIT_MESSAGE_COLOR.r, OUTFIT_MESSAGE_COLOR.g, OUTFIT_MESSAGE_COLOR.b);

		if not gKaymonsCloset_SetSwapInProgress then
			-- no actual swaps needed made, can safely update
			KaymonsCloset_Update(true);
		end
	else
		UIErrorsFrame:AddMessage(KaymonsCloset_cCantEquipInCombat, COMBAT_MESSAGE_COLOR.r, COMBAT_MESSAGE_COLOR.g, COMBAT_MESSAGE_COLOR.b);
	end
end

-- finds a bag with open slots
function KaymonsCloset_FindOpenBag(start)
    local slots;
    for i = start, 4 do
        slots, bagType = GetContainerNumFreeSlots(i);
        if(slots > 0 and bagType == 0) then
            KaymonsCloset_Print("Found bag: " .. tostring(i) .. " with slots: " .. tostring(slots), true);
            KaymonsCloset_Print("bagType: " .. tostring(bagType), true);
            return i, slots;
        end
    end
    return -1, 0;
end


-- clears all saved gear sets
function KaymonsCloset_Reset()
	wipe(gKaymonsCloset_Settings);
	KaymonsCloset_Initialize();
    KaymonsCloset_Print("Cleared Kaymons Closet");
end

local gKaymonsCloset_LastBindingIndex = nil;
local gKaymonsCloset_LastBindingTime = nil;
local KaymonsCloset_cMinBindingTime = 0.75;

function KaymonsCloset_WearBoundOutfit(pBindingIndex)
	-- Check for the user spamming the button so prevent the outfit from
	-- toggling if they're panicking
	
	local vTime = GetTime();
	
	if gKaymonsCloset_LastBindingIndex == pBindingIndex then
		local vElapsed = vTime - gKaymonsCloset_LastBindingTime;
		
		if vElapsed < KaymonsCloset_cMinBindingTime then
			gKaymonsCloset_LastBindingTime = vTime;
			return;
		end
    end
    
	for _, vOutfit in pairs(gKaymonsCloset_Settings.Outfits["Sets"]) do
        if vOutfit.BindingIndex == pBindingIndex then

            KaymonsCloset_EquipGearSet(vOutfit);
            -- if not gKaymonsCloset_Settings.Options.DisableHotkeyMessages then
            --     UIErrorsFrame:AddMessage(format(KaymonsCloset_cEquipOutfitMessageFormat, vOutfit.Name), OUTFIT_MESSAGE_COLOR.r, OUTFIT_MESSAGE_COLOR.g, OUTFIT_MESSAGE_COLOR.b);
            -- end
            
            -- Remember the binding used to filter for button spam
            
            gKaymonsCloset_LastBindingIndex = pBindingIndex;
            gKaymonsCloset_LastBindingTime = vTime;
            
            return;
		end
	end
end

-- for debugging
function KaymonsCloset_tprint(tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            DEFAULT_CHAT_FRAME:AddMessage(formatting)
            KaymonsCloset_tprint(v, indent+1)
        elseif type(v) == 'boolean' then
            DEFAULT_CHAT_FRAME:AddMessage(formatting .. tostring(v))
        else
            DEFAULT_CHAT_FRAME:AddMessage(formatting .. v)
        end
    end
end

function KaymonsCloset_SetShowMinimapButton(pShowButton)
	gKaymonsCloset_Settings.Options.HideMinimapButton = not pShowButton;
	
	if gKaymonsCloset_Settings.Options.HideMinimapButton then
		KaymonsClosetMinimapButton:Hide();
	else
		KaymonsClosetMinimapButton:Show();
	end
	
	KaymonsCloset_Update();
end

function KaymonsCloset_SetRememberVisibility(pRememberVisibility)
	gKaymonsCloset_Settings.Options.DisableAutoVisibility = not pRememberVisibility;
	
	KaymonsCloset_Update();
end

function KaymonsCloset_SetShowHotkeyMessages(pShowHotkeyMessages)
	gKaymonsCloset_Settings.Options.DisableHotkeyMessages = not pShowHotkeyMessages;
	
	KaymonsCloset_Update();
end

function KaymonsCloset_ItemInBank(link)
	if not gKaymonsCloset_BankFrameOpened then
		return false;
	end

	-- check the big bank tab
	for j = 1, 24 do
		local banklink = GetContainerItemLink(-1, j);
		if banklink == link then
			return true;
		end
	end
	-- check the rest of the bags
	for vBagIndex = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		for j = 1, GetContainerNumSlots(vBagIndex) do
			local banklink = GetContainerItemLink(vBagIndex, j);
			if banklink == link then
				return true;
			end
		end
	end
	-- couldnt find
	return false;
end

function KaymonsCloset_GetBankedAndMissingItems(pOutfit)
	local banked = {};
	local missing = {};
	for slotname, link in pairs(pOutfit.Items) do
		if link ~= "nil" and link ~= "" and KaymonsCloset_ItemInBank(link) then
			table.insert(banked, link);
		elseif link ~= "nil" and link ~= "" and KaymonsCloset_IsMissing(link) then
			table.insert(missing, link);
		end
	end
	if table.getn(banked) == 0 then
		banked = nil;
	end
	if table.getn(missing) == 0 then
		missing = nil;
	end
	return banked, missing;
end

function KaymonsCloset_OnShow(self)
	KaymonsCloset_ShowPanel(self, 1); -- Always switch to the main view when showing the window
end

function KaymonsCloset_OnHide()
	KaymonsCloset_ClearSelection();
	-- KaymonsClosetQuickSlots_Close();
	KaymonsClosetFrame:Hide(); -- This seems redundant, but the OnHide handler gets called
	                       -- in response to the parent being hidden (the character window)
	                       -- so calling Hide() on the frame here ensures that when the
	                       -- character window is hidden then KaymonsCloset won't be displayed
	                       -- next time it's opened
end

function KaymonsCloset_ClearSelection()
	gKaymonsCloset_SelectedOutfit = nil;
	KaymonsClosetSlotEnables:Hide();
end

-- function KaymonsClosetQuickSlots_Close()
-- 	KaymonsClosetQuickSlots:Hide();
-- end

function KaymonsCloset_ErrorMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(string.format(KaymonsCloset_PrintFormat, msg))
end

function KaymonsCloset_ToggleKaymonsClosetFrame()
    if KaymonsCloset_IsOpen() then
		KaymonsClosetFrame:Hide();
	else
		KaymonsClosetFrame:Show();
	end
end

function KaymonsCloset_IsOpen()
	return KaymonsClosetFrame:IsVisible();
end

function KaymonsClosetItem_SetToCategory(pItemIndex, pCategoryID)
    local vCategoryName = "Sets" -- getglobal("KaymonsCloset_c"..pCategoryID.."Outfits");
	local vItemName = "KaymonsClosetItem"..pItemIndex;
	local vItem = getglobal(vItemName);
	local vCategoryFrameName = vItemName.."Category";
	local vOutfitFrame = getglobal(vItemName.."Outfit");
	local vItemFrame = getglobal(vItemName.."Item");
    local vCategoryFrame = getglobal(vCategoryFrameName);
    
    vOutfitFrame:Hide();
	vCategoryFrame:Show();
    vItemFrame:Hide();
    
	local vItemNameField = getglobal(vCategoryFrameName.."Name");
    local vExpandButton = getglobal(vCategoryFrameName.."Expand");
    
    vItem.MissingItems = nil;
    vItem.BankedItems = nil;
    
    if gKaymonsCloset_Collapsed[pCategoryID] then
		vExpandButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up"); 
	else
		vExpandButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
    end
    
    vItemNameField:SetText(vCategoryName);
    
	vItem.isCategory = true;
	vItem.isOutfitItem = false;
	vItem.outfitItem = nil;
	vItem.categoryID = pCategoryID;
	
	vItem:Show();
end

function KaymonsCloset_WearingOutfit(pOutfit)
	for slotname, item in pairs(pOutfit.Items) do
		-- if item == "" then skip (dont care)
		if item ~= "" and gKaymonsCloset_CurrentOutfit.Items[slotname] ~= item then 
			return false;
		end
	end
	return true;
end

function KaymonsCloset_SlotEnableClicked(pCheckbox, pButton)
	-- If the user is attempting to drop an item put it in the slot for them
	
	if CursorHasItem() then
		local vSlotID, vEmptySlotTexture = GetInventorySlotInfo(pCheckbox.SlotName);
		PickupInventoryItem(vSlotID);
		return;
	end
	
	local vChecked = pCheckbox:GetChecked();
	
	KaymonsCloset_SetSlotEnable(pCheckbox.SlotName, vChecked);
	KaymonsCloset_Update();
end

function KaymonsCloset_SelectOutfit(pOutfit)
	if not KaymonsCloset_IsOpen() then
		return;
	end
	
	gKaymonsCloset_SelectedOutfit = pOutfit;
	
	-- Update the slot enables
	
	KaymonsCloset_UpdateSlotEnables(pOutfit);
	KaymonsClosetSlotEnables:Show();
end

function KaymonsClosetItemList_InventorySlotContainsItem(pInventorySlot, pOutfitItem)
	-- Nil items are supposed to be ignored, so never claim the slot contains them
	
	if pOutfitItem == nil then
		return false;
	end
	
	local link = GetInventoryItemLink("player", GetInventorySlotInfo(pInventorySlot));
	if pOutfitItem == "nil" then
		-- slot should be empty
		return link == nil;
	else
		return pOutfitItem == link;
	end
end

function KaymonsCloset_UpdateSlotEnables(pOutfit)
	if UnitHasRelicSlot("player") then
		KaymonsClosetEnableAmmoSlot:Hide();
	else
		KaymonsClosetEnableAmmoSlot:Show();
	end
	
	for vInventorySlot, _ in pairs(KaymonsCloset_SlotInfo) do
		local vOutfitItem = pOutfit.Items[vInventorySlot];
		local vCheckbox = getglobal("KaymonsClosetEnable"..vInventorySlot);
		
		if vOutfitItem == "" then
			vCheckbox:SetChecked(false);
		else
			if KaymonsClosetItemList_InventorySlotContainsItem(vInventorySlot, vOutfitItem) then
				vCheckbox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
				vCheckbox.IsUnknown = false;
			else
				vCheckbox:SetCheckedTexture("Interface\\Addons\\KaymonsCloset\\Textures\\CheckboxUnknown");
				vCheckbox.IsUnknown = true;
			end
			vCheckbox:SetChecked(true);
		end
	end
end

function KaymonsClosetItem_SetToOutfit(pItemIndex, pOutfit, pCategoryID, pOutfitIndex)
	local vItemName = "KaymonsClosetItem"..pItemIndex;
	local vItem = getglobal(vItemName);
	local vOutfitFrameName = vItemName.."Outfit";
	local vOutfitFrame = getglobal(vOutfitFrameName);
	local vItemFrame = getglobal(vItemName.."Item");
	local vCategoryFrame = getglobal(vItemName.."Category");

    vOutfitFrame:Show();
	vCategoryFrame:Hide();
    vItemFrame:Hide();

    local vItemSelectedCheckmark = getglobal(vOutfitFrameName.."Selected");
	local vItemNameField = getglobal(vOutfitFrameName.."Name");
	local vItemMenu = getglobal(vOutfitFrameName.."Menu");
    
    vItemSelectedCheckmark:Show();
	
    if KaymonsCloset_WearingOutfit(pOutfit) then
		vItemSelectedCheckmark:SetChecked(true);
	else
		vItemSelectedCheckmark:SetChecked(nil);
    end
	
	local vBankedItems, vMissingItems = KaymonsCloset_GetBankedAndMissingItems(pOutfit);
	vItem.MissingItems = vMissingItems;
    vItem.BankedItems = vBankedItems;
    
    
	vItemNameField:SetText(pOutfit.Name);
	if vMissingItems then
		vItem.DefaultColor = RED_FONT_COLOR;
	elseif vBankedItems then
		vItem.DefaultColor = BANKED_FONT_COLOR;
	else
		vItem.DefaultColor = NORMAL_FONT_COLOR;
	end
    
    vItemNameField:SetTextColor(vItem.DefaultColor.r, vItem.DefaultColor.g, vItem.DefaultColor.b);
	
	vItemMenu:Show();
	
	vItem.isCategory = false;
	vItem.isOutfitItem = false;
	vItem.outfitItem = nil;
	vItem.categoryID = pCategoryID;
	vItem.outfitIndex = pOutfitIndex;
	
	vItem:Show();
	
	-- Update the highlighting
	
	if gKaymonsCloset_SelectedOutfit == pOutfit then
		KaymonsClosetMainFrameHighlight:SetPoint("TOPLEFT", vItem, "TOPLEFT", 0, 0);
		KaymonsClosetMainFrameHighlight:Show();
	end

	return setselected;
end

function KaymonsCloset_AddOutfitsToList(pOutfits, pCategoryID, pItemIndex, pFirstItemIndex)
    if pFirstItemIndex == 0 then
		KaymonsClosetItem_SetToCategory(pItemIndex, pCategoryID, false);
		pItemIndex = pItemIndex + 1;
	else
		pFirstItemIndex = pFirstItemIndex - 1;
    end
    
    if pItemIndex >= KaymonsCloset_cMaxDisplayedItems then
		return pItemIndex, pFirstItemIndex;
    end
    
	if not gKaymonsCloset_Collapsed[pCategoryID] and pOutfits then
		for pIndex, pOutfit in pairs(pOutfits) do
			if pFirstItemIndex == 0 then
				KaymonsClosetItem_SetToOutfit(pItemIndex, pOutfit, pCategoryID, pIndex);
				pItemIndex = pItemIndex + 1;
				
				if pItemIndex >= KaymonsCloset_cMaxDisplayedItems then
					return pItemIndex, pFirstItemIndex;
				end
			else
				pFirstItemIndex = pFirstItemIndex - 1;
			end
        end
	end
	
	return pItemIndex, pFirstItemIndex;
end

function KaymonsCloset_Update(pUpdateSlotEnables)
    if not KaymonsClosetFrame:IsVisible() then
		return;
	end
	
    if gKaymonsCloset_CurrentPanel == 1 then

		KaymonsClosetMainFrameHighlight:Hide();
		
		if pUpdateSlotEnables then
			KaymonsCloset_SelectOutfit(gKaymonsCloset_SelectedOutfit);
		end
        
        local vFirstItemIndex = FauxScrollFrame_GetOffset(KaymonsClosetMainFrameScrollFrame);
        local vItemIndex = 0;
        
        vItemIndex, vFirstItemIndex = KaymonsCloset_AddOutfitsToList(gKaymonsCloset_Settings.Outfits["Sets"], 1, vItemIndex, vFirstItemIndex)
		
		for vItemIndex2 = vItemIndex, (KaymonsCloset_cMaxDisplayedItems - 1) do
			local vItemName = "KaymonsClosetItem" .. vItemIndex2;
			getglobal(vItemName):Hide();
		end
        
        local vTotalNumItems = table.getn(gKaymonsCloset_cCategoryOrder) + table.getn(gKaymonsCloset_Settings.Outfits["Sets"])

        FauxScrollFrame_Update(
            KaymonsClosetMainFrameScrollFrame,
            vTotalNumItems,                 -- numItems
            KaymonsCloset_cMaxDisplayedItems,   -- numToDisplay
            18,                             -- valueStep
            nil, nil, nil,                  -- button, smallWidth, bigWidth
            nil,                            -- highlightFrame
            0, 0);                          -- smallHighlightWidth, bigHighlightWidth
    elseif gKaymonsCloset_CurrentPanel == 2 then -- Options panel
        KaymonsClosetShowMinimapButton:SetChecked(not gKaymonsCloset_Settings.Options.HideMinimapButton);
        KaymonsClosetRememberVisibility:SetChecked(not gKaymonsCloset_Settings.Options.DisableAutoVisibility);
        KaymonsClosetShowHotkeyMessages:SetChecked(not gKaymonsCloset_Settings.Options.DisableHotkeyMessages);
	end
end

function KaymonsCloset_OnVerticalScroll()
	KaymonsCloset_Update();
end

function KaymonsCloset_ShowPanel(self, pPanelIndex)
	
	if gKaymonsCloset_CurrentPanel > 0 and gKaymonsCloset_CurrentPanel ~= pPanelIndex then
		KaymonsCloset_HidePanel(gKaymonsCloset_CurrentPanel);
	end
	
	-- NOTE: Don't check for redundant calls since this function
	-- will be called to reset the field values as well as to 
	-- actually show the panel when it's hidden
	
	gKaymonsCloset_CurrentPanel = pPanelIndex;
	
	getglobal(gKaymonsCloset_PanelFrames[pPanelIndex]):Show();
	
	PanelTemplates_SetTab(KaymonsClosetFrame, pPanelIndex);
	
	-- Update the control values
	
	if pPanelIndex == 1 then
		-- Main panel
		
	elseif pPanelIndex == 2 then
		-- Options panel
		
	elseif pPanelIndex == 3 then
		-- About panel
		
	else
		KaymonsCloset_ErrorMessage("KaymonsCloset: Unknown index ("..pPanelIndex..") in ShowPanel()");
	end
	
	KaymonsCloset_Update();
end

function KaymonsCloset_HidePanel(pPanelIndex)
	if gKaymonsCloset_CurrentPanel ~= pPanelIndex then
		return;
	end
	
	getglobal(gKaymonsCloset_PanelFrames[pPanelIndex]):Hide();
	gKaymonsCloset_CurrentPanel = 0;
end

function KaymonsClosetScrollbarTrench_SizeChanged(pScrollbarTrench)
	local vScrollbarTrenchName = pScrollbarTrench:GetName();
	local vScrollbarTrenchMiddle = getglobal(vScrollbarTrenchName.."Middle");
	
	local vMiddleHeight= pScrollbarTrench:GetHeight() - 51;
	vScrollbarTrenchMiddle:SetHeight(vMiddleHeight);
end

function KaymonsClosetInputBox_OnLoad(self, pChildDepth)
	if not pChildDepth then
		pChildDepth = 0;
	end
	
	local vParent = self:GetParent();
	
	for vDepthIndex = 1, pChildDepth do
		vParent = vParent:GetParent();
	end
	
	if vParent.lastEditBox then
		self.prevEditBox = vParent.lastEditBox;
		self.nextEditBox = vParent.lastEditBox.nextEditBox;
		
		self.prevEditBox.nextEditBox = self;
		self.nextEditBox.prevEditBox = self;
	else
		self.prevEditBox = self;
		self.nextEditBox = self;
	end

	vParent.lastEditBox = self;
end

function KaymonsClosetItemDropDown_OnLoad(self)
	UIDropDownMenu_SetAnchor(self, 0, 0, "TOPLEFT", self:GetName(), "CENTER");
	UIDropDownMenu_Initialize(self, KaymonsClosetItemDropDown_Initialize);
	
	self:SetHeight(self.SavedHeight);
end

function KaymonsCloset_AddCategoryMenuItem(pName)
	UIDropDownMenu_AddButton({text = pName, notCheckable = true, notClickable = true});
end

function KaymonsCloset_AddMenuItem(pFrame, pName, pValue, pChecked, pLevel, pColor, pDisabled)
	if not pColor then
		pColor = NORMAL_FONT_COLOR;
	end
	
	UIDropDownMenu_AddButton({text = pName, value = pValue, owner = pFrame, checked = pChecked, func = KaymonsClosetDropDown_OnClick2, textR = pColor.r, textG = pColor.g, textB = pColor.b, disabled = pDisabled}, pLevel);
end

function KaymonsCloset_AddSubmenuItem(pFrame, pName, pValue)
	UIDropDownMenu_AddButton({text = pName, owner = pFrame, hasArrow = 1, value = pValue, textR = NORMAL_FONT_COLOR.r, textG = NORMAL_FONT_COLOR.g, textB = NORMAL_FONT_COLOR.b});
end

function KaymonsCloset_AddCategoryMenuItem(pName)
	UIDropDownMenu_AddButton({text = pName, notCheckable = true, notClickable = true});
end

function KaymonsCloset_GetOutfit(name)
	for _, vOutfit in pairs(gKaymonsCloset_Settings.Outfits["Sets"]) do
		if string.upper(vOutfit.Name) == string.upper(name) then
			return vOutfit;
		end
	end
	return nil;
end

function KaymonsClosetItemDropDown_Initialize(self)
	local vFrame = self;
	-- local	vFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	local vItem = vFrame:GetParent():GetParent();
	local name = getglobal(vItem:GetName() .. "OutfitName"):GetText();
	local vOutfit = KaymonsCloset_GetOutfit(name);
	
	if not vOutfit then
		return;
	end
	
	if UIDROPDOWNMENU_MENU_LEVEL == 1 then
		
		KaymonsCloset_AddCategoryMenuItem(vOutfit.Name);
		
        KaymonsCloset_AddMenuItem(vFrame, PET_RENAME, "RENAME");
		
		KaymonsCloset_AddSubmenuItem(vFrame, KaymonsCloset_cKeyBinding, "BINDING");
		
        KaymonsCloset_AddMenuItem(vFrame, DELETE, "DELETE");
		
		KaymonsCloset_AddCategoryMenuItem(KaymonsCloset_cBankCategoryTitle);
		KaymonsCloset_AddMenuItem(vFrame, KaymonsCloset_cDepositToBank, "DEPOSIT", nil, nil, nil, not gKaymonsCloset_BankFrameOpened);
		KaymonsCloset_AddMenuItem(vFrame, KaymonsCloset_cDepositUniqueToBank, "DEPOSITUNIQUE", nil, nil, nil, not gKaymonsCloset_BankFrameOpened);
		KaymonsCloset_AddMenuItem(vFrame, KaymonsCloset_cWithdrawFromBank, "WITHDRAW", nil, nil, nil, not gKaymonsCloset_BankFrameOpened);
		
	elseif UIDROPDOWNMENU_MENU_LEVEL == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "BINDING" then
			for vIndex = 1, 10 do
				KaymonsCloset_AddMenuItem(vFrame, getglobal("BINDING_NAME_KAYMONSCLOSET_OUTFIT"..vIndex), "BINDING"..vIndex, vOutfit.BindingIndex == vIndex, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	end
	
	vFrame:SetHeight(vFrame.SavedHeight);
end

function KaymonsClosetMinimapButton_UpdateDragPosition(self)
	-- Remember where the cursor was in case the user drags
	
	local vCursorX, vCursorY = GetCursorPosition();
	
	vCursorX = vCursorX / self:GetEffectiveScale();
	vCursorY = vCursorY / self:GetEffectiveScale();

	if KaymonsClosetMinimapButton.CursorStartX == nil then
		KaymonsClosetMinimapButton_MouseDown(self);
	end
	
	local	vCursorDeltaX = vCursorX - KaymonsClosetMinimapButton.CursorStartX;
	local	vCursorDeltaY = vCursorY - KaymonsClosetMinimapButton.CursorStartY;
	
	--
	
	local	vCenterX = KaymonsClosetMinimapButton.CenterStartX + vCursorDeltaX;
	local	vCenterY = KaymonsClosetMinimapButton.CenterStartY + vCursorDeltaY;
	
	-- Calculate the angle
	
	local	vAngle = math.atan2(vCenterX, vCenterY);
	
	-- Set the new position
	
	KaymonsClosetMinimapButton_SetPositionAngle(vAngle);
end

function KaymonsClosetTimer_AdjustTimer()
	local vNeedTimer = false;
	
	if KaymonsClosetMinimapButton.IsDragging then
		vNeedTimer = true;
	end
	
	if gKaymonsCloset_EquippedNeedsUpdate or gKaymonsCloset_WeaponsNeedUpdate then
		vNeedTimer = true;
	end
	
	if vNeedTimer then
		KaymonsClosetUpdateFrame:Show();
	else
		KaymonsClosetUpdateFrame:Hide();
		KaymonsClosetUpdateFrame.Elapsed = nil;
	end
end

function KaymonsClosetMinimapDropDown_AdjustScreenPosition(pMenu)
	local	vListFrame = getglobal("DropDownList1");
	
	if not vListFrame:IsVisible() then
		return;
	end
	
	local	vCenterX, vCenterY = pMenu:GetCenter();
	local	vScreenWidth, vScreenHeight = GetScreenWidth(), GetScreenHeight();
	
	local	vAnchor;
	local	vOffsetX, vOffsetY;
	
	if vCenterY < vScreenHeight / 2 then
		vAnchor = "BOTTOM";
		vOffsetY = -8;
	else
		vAnchor = "TOP";
		vOffsetY = -17;
	end
	
	if vCenterX < vScreenWidth / 2 then
		vAnchor = vAnchor.."LEFT";
		vOffsetX = 21;
	else
		vAnchor = vAnchor.."RIGHT";
		vOffsetX = 3;
	end
	
	vListFrame:ClearAllPoints();
	vListFrame:SetPoint(vAnchor, pMenu.relativeTo, pMenu.relativePoint, vOffsetX, vOffsetY);
end

function KaymonsClosetUpdateFrame_OnUpdate(self, pElapsed)
	if KaymonsClosetMinimapButton.IsDragging then
		KaymonsClosetMinimapButton_UpdateDragPosition(self);
	end
	
	if not KaymonsClosetUpdateFrame.Elapsed then
		KaymonsClosetUpdateFrame.Elapsed = 0;
	else
		KaymonsClosetUpdateFrame.Elapsed = KaymonsClosetUpdateFrame.Elapsed + pElapsed;
		
		if KaymonsClosetUpdateFrame.Elapsed > 0.25 then
			-- KaymonsCloset_UpdateEquippedItems();
			KaymonsClosetUpdateFrame.Elapsed = 0;
		end
	end
	
	KaymonsClosetTimer_AdjustTimer();
end

function KaymonsClosetMinimapButton_DragStart()
	KaymonsClosetMinimapButton.IsDragging = true;
	KaymonsClosetTimer_AdjustTimer();
end

function KaymonsClosetMinimapButton_DragEnd()
	KaymonsClosetMinimapButton.IsDragging = false;
	KaymonsClosetTimer_AdjustTimer();
end

function KaymonsClosetMinimapButton_MouseDown(self)
	-- Remember where the cursor was in case the user drags
	
	local	vCursorX, vCursorY = GetCursorPosition();
	
	vCursorX = vCursorX / self:GetEffectiveScale();
	vCursorY = vCursorY / self:GetEffectiveScale();
	
	KaymonsClosetMinimapButton.CursorStartX = vCursorX;
	KaymonsClosetMinimapButton.CursorStartY = vCursorY;
	
	local	vCenterX, vCenterY = KaymonsClosetMinimapButton:GetCenter();
	local	vMinimapCenterX, vMinimapCenterY = Minimap:GetCenter();
	
	KaymonsClosetMinimapButton.CenterStartX = vCenterX - vMinimapCenterX;
	KaymonsClosetMinimapButton.CenterStartY = vCenterY - vMinimapCenterY;
end

function KaymonsCloset_RestrictAngle(pAngle, pRestrictStart, pRestrictEnd)
	if pAngle <= pRestrictStart or pAngle >= pRestrictEnd then
		return pAngle;
	end
	
	local vDistance = (pAngle - pRestrictStart) / (pRestrictEnd - pRestrictStart);
	
	if vDistance > 0.5 then
		return pRestrictEnd;
	else
		return pRestrictStart;
	end
end

function KaymonsClosetMinimapButton_SetPositionAngle(pAngle)
	local vAngle = pAngle;
	
	-- Restrict the angle from going over the date/time icon or the zoom in/out icons
	
	local vRestrictedStartAngle = nil;
	local vRestrictedEndAngle = nil;
	
	if GameTimeFrame:IsVisible() then
		if MinimapZoomIn:IsVisible()
		or MinimapZoomOut:IsVisible() then
			vAngle = KaymonsCloset_RestrictAngle(vAngle, 0.4302272732931596, 2.930420793963121);
		else
			vAngle = KaymonsCloset_RestrictAngle(vAngle, 0.4302272732931596, 1.720531504573905);
		end
		
	elseif MinimapZoomIn:IsVisible() or MinimapZoomOut:IsVisible() then
		vAngle = KaymonsCloset_RestrictAngle(vAngle, 1.720531504573905, 2.930420793963121);
	end
	
	-- Restrict it from the tracking icon area
	
	vAngle = KaymonsCloset_RestrictAngle(vAngle, -1.290357134304173, -0.4918423429923585);
	
	--
	
	local	vRadius = 80;
	
	vCenterX = math.sin(vAngle) * vRadius;
	vCenterY = math.cos(vAngle) * vRadius;
	
	KaymonsClosetMinimapButton:SetPoint("CENTER", "Minimap", "CENTER", vCenterX - 1, vCenterY - 1);
	
	gKaymonsCloset_Settings.Options.MinimapButtonAngle = vAngle;
end

function KaymonsClosetMinimapDropDown_OnLoad(self)
	UIDropDownMenu_SetAnchor(self, 3, -7, "TOPRIGHT", self:GetName(), "TOPLEFT");
	UIDropDownMenu_Initialize(self, KaymonsClosetMinimapDropDown_Initialize);	
end

function KaymonsClosetMinimapDropDown_Initialize(self)
	-- Just return if not initialized yet
	
	if not gKaymonsCloset_Initialized then
		return;
	end
	
    local vFrame = self; -- getglobal(UIDROPDOWNMENU_INIT_MENU);
	
	KaymonsCloset_AddCategoryMenuItem(KaymonsCloset_cTitleVersion);
	KaymonsCloset_AddMenuItem(vFrame, KaymonsCloset_cOpenKaymonsCloset, 0);
	
	KaymonsClosetMinimapDropDown_InitializeOutfitList(self);
end

function KaymonsClosetMinimapDropDown_InitializeOutfitList(self)
	-- Just return if not initialized yet
	
	if not gKaymonsCloset_Initialized then
		return;
	end
	
	local vFrame = self; -- getglobal(UIDROPDOWNMENU_INIT_MENU);
	
    KaymonsCloset_AddCategoryMenuItem("Sets");
    
    for vIndex, vOutfit in pairs(gKaymonsCloset_Settings.Outfits["Sets"]) do
        KaymonsCloset_AddMenuItem(vFrame, vOutfit.Name, vOutfit);
    end
end

function KaymonsClosetDropDown_OnClick(self)
	UIDropDownMenu_SetSelectedValue(self.owner, self.value);
	KaymonsClosetDropDown_OnClick2(self);
end

function KaymonsCloset_HasGearSetName(name)
	for _, vOutfit in pairs(gKaymonsCloset_Settings.Outfits["Sets"]) do
		if vOutfit.Name == name then
			return true;
		end
	end
	return false;
end

function KaymonsClosetDropDown_OnClick2(self)
	if self.owner and self.owner.ChangedValueFunc then
		self.owner.ChangedValueFunc(self.owner, self.value);
	end
	
	CloseDropDownMenus();
end

function KaymonsClosetMinimapButton_ItemSelected(self, pValue)
	local vType = type(pValue);

	if vType == "table" then
		if not KaymonsCloset_WearingOutfit(pValue) then
			KaymonsCloset_EquipGearSet(pValue);
		end
		
		if vDoToggle then
			return true;
		end
	elseif pValue == 0 then -- Open KaymonsCloset
		ShowUIPanel(CharacterFrame);
		CharacterFrame_ShowSubFrame("PaperDollFrame");
		KaymonsClosetFrame:Show();
	end
	
	return false;
end

function KaymonsClosetDropDown_SetSelectedValue(pDropDown, pValue)
	UIDropDownMenu_SetText(pDropDown, ""); -- Set to empty in case the selected value isn't there

	UIDropDownMenu_Initialize(pDropDown, pDropDown.initialize);
	UIDropDownMenu_SetSelectedValue(pDropDown, pValue);
	
	-- All done if the item text got set successfully
	
	local vItemText = UIDropDownMenu_GetText(pDropDown);
	
	if vItemText and vItemText ~= "" then
		return;
	end
	
	-- Scan for submenus
	
	local vRootListFrameName = "DropDownList1";
	local vRootListFrame = getglobal(vRootListFrameName);
	local vRootNumItems = vRootListFrame.numButtons;
	
	for vRootItemIndex = 1, vRootNumItems do
		local vItem = getglobal(vRootListFrameName.."Button"..vRootItemIndex);
		
		if vItem.hasArrow then
			local vSubMenuFrame = getglobal("DropDownList2");
			
			UIDROPDOWNMENU_OPEN_MENU = pDropDown:GetName();
			UIDROPDOWNMENU_MENU_VALUE = vItem.value;
			UIDROPDOWNMENU_MENU_LEVEL = 2;
			
			UIDropDownMenu_Initialize(pDropDown, pDropDown.initialize, nil, 2);
			UIDropDownMenu_SetSelectedValue(pDropDown, pValue);
			
			-- All done if the item text got set successfully
			
			local vItemText = UIDropDownMenu_GetText(pDropDown);
			
			if vItemText and vItemText ~= "" then
				return;
			end
			
			-- Switch back to the root menu
			
			UIDROPDOWNMENU_OPEN_MENU = nil;
			UIDropDownMenu_Initialize(pDropDown, pDropDown.initialize, nil, 1);
		end
	end
end

function KaymonsCloset_SetAllSlotEnables(pEnable)
	for vInventorySlot, _ in pairs(KaymonsCloset_SlotInfo) do
		KaymonsCloset_SetSlotEnable(vInventorySlot, pEnable);
	end
	
	KaymonsCloset_Update(true);
end

function KaymonsCloset_SetSlotEnable(pSlotName, pEnable)
	if not gKaymonsCloset_SelectedOutfit then
		return;
	end
	
	if pEnable then
		local vItemLink = KaymonsCloset_GetInventoryItemLink(pSlotName);
		
		gKaymonsCloset_SelectedOutfit.Items[pSlotName] = vItemLink;
	else
		gKaymonsCloset_SelectedOutfit.Items[pSlotName] = "";
	end
end

function KaymonsCloset_GetInventoryItemLink(pInventorySlot)
	local vSlotID = GetInventorySlotInfo(pInventorySlot);
	local vItemLink = GetInventoryItemLink("player", vSlotID);
	
	if vItemLink then
		return vItemLink;
	end

	return "nil"
end

function KaymonsCloset_OutfitItemSelected(self, pValue)
	local vItem = self:GetParent():GetParent();
	local name = getglobal(vItem:GetName() .. "OutfitName"):GetText();
	local vOutfit = KaymonsCloset_GetOutfit(name);
	
	if not vOutfit then
		KaymonsCloset_ErrorMessage("KaymonsCloset Error: Outfit for menu item "..vItem:GetName().." not found");
		return;
	end
	
	-- Perform the selected action
	
	if pValue == "DELETE" then
		KaymonsCloset_AskDeleteOutfit(vOutfit);
	elseif pValue == "RENAME" then
		KaymonsClosetNameOutfit_Open(vOutfit);
	elseif string.sub(pValue, 1, 7) == "BINDING" then
		KaymonsCloset_SetOutfitBindingIndex(vOutfit, tonumber(string.sub(pValue, 8)));
	elseif pValue == "DEPOSIT" then
		KaymonsCloset_DepositOutfit(vOutfit);
	elseif pValue == "DEPOSITUNIQUE" then
		KaymonsCloset_DepositOutfit(vOutfit, true);
	elseif pValue == "WITHDRAW" then
		KaymonsCloset_WithdrawOutfit(vOutfit);
	end
	
	KaymonsCloset_Update();
end

function KaymonsCloset_AskDeleteOutfit(pOutfit)
	gKaymonsCloset_OutfitToDelete = pOutfit;
	StaticPopup_Show("KAYMONSCLOSET_CONFIRM_DELETE", gKaymonsCloset_OutfitToDelete.Name);
end

function KaymonsCloset_DeleteSelectedOutfit()
	if not gKaymonsCloset_OutfitToDelete then
		return;
	end

	KaymonsCloset_DeleteOutfit(gKaymonsCloset_OutfitToDelete);

	KaymonsCloset_Update();
end

function KaymonsCloset_SetOutfitBindingIndex(pOutfit, pBindingIndex)
	for _, vOutfit in pairs(gKaymonsCloset_Settings.Outfits["Sets"]) do
		if vOutfit.BindingIndex == pBindingIndex then
			vOutfit.BindingIndex = nil;
		end
	end
	
	pOutfit.BindingIndex = pBindingIndex;
end

function KaymonsCloset_GetItemInfoFromLink(pItemLink)
	if not pItemLink then
		return nil;
	end
	-- |cff1eff00|Hitem:1465:803:0:0|h[Tigerbane]|h|r
	-- |cff1eff00|Hitem:1465:803:0:0|h[Tigerbane]|h|r
	-- |(hex code for item color)|Hitem:(item ID code):(enchant code):(added stats code):0|h[(item name)]|h|r
	

	local vItemName = string.match(pItemLink, "%[(.+)%]")
	local itemString = string.match(pItemLink, "item[%-?%d:]+")
	local _, vItemCode, vItemEnchantCode, _, _, _, _, vItemSubCode, _, _, _, _, _, _ = strsplit(":", itemString)
	-- local vStartIndex, vEndIndex, vItemColor, vItemCode, vItemEnchantCode, vItemSubCode, vUnknownCode, vItemName = strfind(pItemLink, "|(%x+)|Hitem:(%d+):(%d+):(%d+):(%d+)|h%[([^%]]+)%]|h|r");
	
	if vItemName == nil or itemString == nil then
		return nil;
	end
	
	vItemCode = tonumber(vItemCode);
	vItemSubCode = tonumber(vItemSubCode);
	vItemEnchantCode = tonumber(vItemEnchantCode);
	
	local _, _, _, _, _, _, _, _, equipSlot = GetItemInfo(vItemCode)

	local	vItemFamilyName,
			vItemLink,
			vItemQuality,
			vItemLevel,
			vItemType,
			vItemSubType,
			vItemCount,
			vItemInvType = equipSlot;
	
	local	vItemInfo =
	{
		Code = vItemCode,
		SubCode = vItemSubCode,
		Name = vItemName,
		EnchantCode = vItemEnchantCode,
		Level = vItemLevel,
	};
	
	-- Just return if there's no inventory type
	
	if not vItemInvType or vItemInvType == "" then
		return vItemInfo;
	end
	
	-- Just return if we don't know anything about the inventory type
	
	local vInvTypeInfo = KaymonsCloset_cInvTypeToSlotName[vItemInvType];
	
	if not vInvTypeInfo then
		KaymonsCloset_ErrorMessage("KaymonsCloset error: Unknown slot type "..vItemInvType.." for item "..vItemName);
		return vItemInfo;
	end
	
	-- Get the slot name
	
	if not vInvTypeInfo.SlotName then
		KaymonsCloset_ErrorMessage("Unknown slot name for inventory type "..vItemInvType);
		return vItemInfo;
	end
	
	vItemInfo.ItemSlotName = vInvTypeInfo.SlotName;
	vItemInfo.MetaSlotName = vInvTypeInfo.MetaSlotName;
	
	-- Return the info
	
	return vItemInfo;
end

function KaymonsCloset_GetBagItemInfo(pBagIndex, pSlotIndex)
	local vItemLink = GetContainerItemLink(pBagIndex, pSlotIndex);
	local vItemInfo = KaymonsCloset_GetItemInfoFromLink(vItemLink);
	
	if not vItemInfo then
		return nil;
	end
	
	vItemInfo.Texture, _, _, vItemInfo.Quality, _ = GetContainerItemInfo(pBagIndex, pSlotIndex);
	
	return vItemInfo;
end

function KaymonsCloset_GetEmptyBagSlot(pStartBagIndex, pStartBagSlotIndex, pIncludeBank)
	local vStartBagIndex = pStartBagIndex;
	local vStartBagSlotIndex = pStartBagSlotIndex;
	
	if not vStartBagIndex then
		vStartBagIndex = NUM_BAG_SLOTS;
	end
	
	if not vStartBagSlotIndex then
		vStartBagSlotIndex = 1;
	end
	
	local vEndBagIndex = 0;
	
	if pIncludeBank then
		vEndBagIndex = -1;
	end
	
	for vBagIndex = vStartBagIndex, vEndBagIndex, -1 do
		-- Skip the bag if it's a specialty bag (ammo pouch, quiver, shard bag)
		
		local	vSkipBag = false;
		
		if vBagIndex > 0 then -- Don't worry about the backpack
			local	vItemLink = GetInventoryItemLink("player", ContainerIDToInventoryID(vBagIndex));
			local	vItemInfo = KaymonsCloset_GetItemInfoFromLink(vItemLink);
			
			if vItemInfo and KaymonsCloset_cSpecialtyBags[vItemInfo.Code] ~= nil then
				vSkipBag = true;
			end
		end
		
		-- Search the bag for empty slots
		
		if not vSkipBag then
			local	vNumBagSlots = GetContainerNumSlots(vBagIndex);
			
			if vNumBagSlots > 0 then
				for vSlotIndex = vStartBagSlotIndex, vNumBagSlots do
					local vItemInfo = KaymonsCloset_GetBagItemInfo(vBagIndex, vSlotIndex);
					
					if not vItemInfo then
						return {BagIndex = vBagIndex, BagSlotIndex = vSlotIndex};
					end
				end
			end
		end
		
		vStartBagSlotIndex = 1;
	end
	
	return nil;
end

function KaymonsCloset_GetEmptyBankSlotList()
	local	vEmptyBagSlots = {};
	
	local vBagIndex = NUM_BAG_SLOTS + NUM_BANKBAGSLOTS;
	local vBagSlotIndex = 1;
	
	while true do
		local vBagSlotInfo = KaymonsCloset_GetEmptyBagSlot(vBagIndex, vBagSlotIndex, true);
		
		if not vBagSlotInfo then
			return vEmptyBagSlots;
		
		elseif vBagSlotInfo.BagIndex > NUM_BAG_SLOTS or vBagSlotInfo.BagIndex < 0 then
			table.insert(vEmptyBagSlots, vBagSlotInfo);
		end
		
		vBagIndex = vBagSlotInfo.BagIndex;
		vBagSlotIndex = vBagSlotInfo.BagSlotIndex + 1;
	end
end

function KaymonsCloset_SubtractOutfit(pOutfit1, pOutfit2)
	for vInventorySlot, _ in pairs(KaymonsCloset_SlotInfo) do
		local vItem1 = pOutfit1.Items[vInventorySlot];
		local vItem2 = pOutfit2.Items[vInventorySlot];

		if vItem1 == vItem2 then
			pOutfit1.Items[vInventorySlot] = nil;
		end
	end
end

function KaymonsCloset_DepositOutfit(pOutfit, pUniqueItemsOnly)
	KaymonsCloset_ClearSelection();

	-- build list of items to bank
	local vUnequipOutfit = KaymonsCloset_NewEmptyOutfit();
	
	for vInventorySlot, vItem in pairs(pOutfit.Items) do
		vUnequipOutfit.Items[vInventorySlot] = vItem;
	end

	if pUniqueItemsOnly then
		for _, vOutfit in pairs(gKaymonsCloset_Settings.Outfits["Sets"]) do
			if vOutfit ~= pOutfit then
				KaymonsCloset_SubtractOutfit(vUnequipOutfit, vOutfit)
			end
		end
	end

	local vEmptyBankSlots = KaymonsCloset_GetEmptyBankSlotList();
	for vInventorySlot, vItem in pairs(vUnequipOutfit.Items) do
		if tostring(vItem) ~= "nil" then
			if not vEmptyBankSlots or table.getn(vEmptyBankSlots) == 0 then
				KaymonsCloset_ErrorMessage(format(KaymonsCloset_cDepositBagsFullError, vItem));
			else
				-- find the item
				local ismissing, i, j = KaymonsCloset_IsMissing(vItem);
				if not ismissing then
					-- pick it up
					if i == 0 and j == 0 then
						-- item is equipped
						PickupInventoryItem(GetInventorySlotInfo(vInventorySlot));
					else
						-- item in bags
						PickupContainerItem(i, j);
					end
					-- find empty bank slot
					local x = vEmptyBankSlots[1].BagIndex;
					local y = vEmptyBankSlots[1].BagSlotIndex;	
					table.remove(vEmptyBankSlots, 1);
					-- put in bank
					PickupContainerItem(x, y);
				end
			end
		end
	end
end

function KaymonsCloset_GetEmptyBagSlotList()
	local	vEmptyBagSlots = {};
	
	local	vBagIndex = NUM_BAG_SLOTS;
	local	vBagSlotIndex = 1;
	
	while true do
		local	vBagSlotInfo = KaymonsCloset_GetEmptyBagSlot(vBagIndex, vBagSlotIndex);
		
		if not vBagSlotInfo then
			return vEmptyBagSlots;
		end
		
		table.insert(vEmptyBagSlots, vBagSlotInfo);
		
		vBagIndex = vBagSlotInfo.BagIndex;
		vBagSlotIndex = vBagSlotInfo.BagSlotIndex + 1;
	end
end

function KaymonsCloset_WithdrawOutfit(pOutfit)
	local vEmptyBagSlots = KaymonsCloset_GetEmptyBagSlotList();

	for vInventorySlot, vItem in pairs(pOutfit.Items) do
		if tostring(vItem) ~= "nil" then
			local ismissing = KaymonsCloset_IsMissing(vItem);
			if ismissing then
				if not vEmptyBagSlots or table.getn(vEmptyBagSlots) == 0 then
					KaymonsCloset_ErrorMessage(format(KaymonsCloset_cWithdrawBagsFullError, vItem));
				else
					-- get it from the bank
					local found = false;
					for j = 1, 24 do
						local link = GetContainerItemLink(-1, j);
						if link and link == vItem then
							PickupContainerItem(-1, j);
							found = true;
							break;
						end
					end
					if not found then
						for i = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
							for j = 1, GetContainerNumSlots(i) do
								local link = GetContainerItemLink(i, j);
								if link and link == vItem then
									PickupContainerItem(-1, j);
									break;
								end
							end
						end
					end
					local x = vEmptyBagSlots[1].BagIndex;
					local y = vEmptyBagSlots[1].BagSlotIndex;	
					table.remove(vEmptyBagSlots, 1);
					-- put in bags
					PickupContainerItem(x, y);
				end
			end
		end
	end
end

function KaymonsClosetItem_CheckboxClicked(pItem)
	if pItem.isCategory then
		return;
	end
	
	local vOutfits = gKaymonsCloset_Settings.Outfits["Sets"];
	
	if not vOutfits then
		-- Error: outfit category not found
		return;
	end
	
	local id = tonumber(string.sub(pItem:GetName(), -1));
	local vOutfit = vOutfits[id];
	
	if not vOutfit then
		-- Error: outfit not found
		return;
	end
	
	local vCheckbox = getglobal(pItem:GetName().."OutfitSelected");
	
	if vCheckbox:GetChecked() then
		KaymonsCloset_EquipGearSet(vOutfit);
	end
	
	KaymonsCloset_Update();
end

function KaymonsClosetItem_OnClick(pItem, pButton)
	if pItem.isCategory then
		local vCategoryOutfits = gKaymonsCloset_Settings.Outfits[pItem.categoryID];
		
		gKaymonsCloset_Collapsed[pItem.categoryID] = not gKaymonsCloset_Collapsed[pItem.categoryID];
	else
		local id = tonumber(string.sub(pItem:GetName(), -1));
		local vOutfit = gKaymonsCloset_Settings.Outfits["Sets"][id];
		
		if not vOutfit then
			return;
		end
		
		KaymonsCloset_EquipGearSet(vOutfit);
	end
	
	KaymonsCloset_Update();
end

function KaymonsClosetItem_SetTextColor(pItem, pRed, pGreen, pBlue)
	local vItemNameField;
	
	if pItem.isCategory then
		vItemNameField = getglobal(pItem:GetName().."CategoryName");
	else
		vItemNameField = getglobal(pItem:GetName().."OutfitName");
	end
	
	vItemNameField:SetTextColor(pRed, pGreen, pBlue);
end

function KaymonsClosetItem_OnEnter(self)
	KaymonsClosetItem_SetTextColor(self, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
end

function KaymonsClosetItem_OnLeave(self)
	if self.isCategory then
		KaymonsClosetItem_SetTextColor(self, 1, 1, 1);
	else
		KaymonsClosetItem_SetTextColor(self, self.DefaultColor.r, self.DefaultColor.g, self.DefaultColor.b);
	end
	
	GameTooltip:Hide();
end
