private ["_uid","_char","_agent","_state","_playerVars","_quickBar","_items"];

_uid = _this;

_char = _uid call fnc_dbFindInProfile;

if !(_char select 0) exitWith {objNull};

_state = call compile callFunction ["DataBaseRead",format ["%1_STATE",_uid]];

_playerVars = _state select 0;

_quickBar = _state select 1;

_items = call compile callFunction ["DataBaseRead",format ["%1_ITEMS",_uid]];

_agent = createAgent [(_char select 1),(_char select 2),[],0,"NONE"];

// Player state
{ _agent setVariable[(_x select 0),(_x select 1)] } forEach _playerVars;

// Inventory Items
null = [_agent,(_items select 0)] call fnc_addInvItems;

null = _agent moveToHands objNull;

// Hands
null = [_agent,(_items select 1)] call fnc_addHandsItem;

// Quickbar 
null = [_agent,_quickBar] call fnc_addQuickBarItems;

// break Legs if ( _agent getVariable ["falldamage",false] ) then {null = breakLegs _agent;};

_agent setPosATL (_char select 2); // _agent setPos (_char select 2);	_agent setposASL (_char select 2);

_agent setDir (_char select 3);

// _agent setVectorUp (_char select 4);

// _agent setVectorDir (_char select 5);

_agent switchMove (_char select 6); 


if (DB_DEBUG) then {diag_log format[":::: dbLoadFromProfile: %1",_char]};

_agent
