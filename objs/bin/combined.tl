/////
//
// Common Types
//
/////

// Builtin types
int ? = Int;
long ? = Long;
double ? = Double;
string ? = String;

// Boolean emulation
boolFalse = Bool;
boolTrue = Bool;

// Boolean for diagonal queries
boolStat statTrue:int statFalse:int statUnknown:int = BoolStat;

// Vector
vector {t:Type} # [t] = Vector t;
tuple {t:Type} {n:#} [t] = Tuple t n;
vectorTotal {t:Type} total_count:int vector:%(Vector t) = VectorTotal t;


statOne key:string value:string = StatOne;
stat vector:%(Vector %statOne) = Stat;
/////
//
// Result- (Maybe-) types
//
/////

resultFalse {t:Type} = Maybe t;
resultTrue {t:Type} result:t = Maybe t;


pair {X:Type} {Y:Type} a:X b:Y = Pair X Y;

map {X:Type} {Y:Type} key:X value:Y = Map X Y;

Empty False;

true = True;

pid host:int port_pid:int utime:int = Pid;

rpcInvokeReqExtra {flags:#} wait_binlog_pos:flags.16?long kitten_php_delay_ms:flags.17?int string_forward_keys:flags.18?%(Vector string) int_forward_keys:flags.19?%(Vector long) string_forward:flags.20?string int_forward:flags.21?long wait_binlog_time:flags.22?long custom_timeout_ms:flags.23?int  = RpcInvokeReqExtra flags;
rpcReqResultExtra {flags:#} binlog_pos:flags.0?long  binlog_time:flags.1?long = RpcReqResultExtra flags;


reqError {X:Type} error_code:int error:string = ReqResult X;
reqResultHeader#8cc84ce1 {X:Type} flags:# extra:%(RpcReqResultExtra flags) result:X = ReqResult X;
//reqResultFalse {X:Type} = ReqResult X;
_ {X:Type} result:X = ReqResult X;

rpcReqResult#63aeda4e {X:Type} query_id:long result:(ReqResult X) = RpcReqResult X;
rpcReqError#7ae432f5 {X:Type} query_id:long error_code:int error:string = RpcReqResult X;

---functions---

rpcDestActor#7568aabd {X:Type} actor_id:long query:!X = X;
rpcDestActorFlags#f0a5acf7 {X:Type} actor_id:long flags:# extra:%(RpcInvokeReqExtra flags) query:!X = X;
rpcDestFlags#e352035e {X:Type} flags:# extra:%(RpcInvokeReqExtra flags) query:!X = X;

rpcInvokeReq#2374df3d {X:Type} query_id:long query:!X = RpcReqResult X;




engine.nop  = True;
engine.stat = Stat;
---types---
/////
//
// Serialized binary TL-schema in vkext format
//
/////

tls.schema_v2 version:int date:int types_num:# types:types_num*[tls.Type] constructor_num:# constructors:constructor_num*[tls.Combinator] functions_num:# functions:functions_num*[tls.Combinator] = tls.Schema;

tls.type name:int id:string constructors_num:int flags:int arity:int params_type:long = tls.Type;
tls.combinator name:int id:string type_name:int left:tls.CombinatorLeft right:tls.CombinatorRight = tls.Combinator;
tls.combinatorLeftBuiltin = tls.CombinatorLeft;
tls.combinatorLeft args_num:# args:args_num*[tls.Arg] = tls.CombinatorLeft;

tls.combinatorRight value:tls.TypeExpr = tls.CombinatorRight;

tls.arg id:string flags:# var_num:flags.1?int exist_var_num:flags.2?int exist_var_bit:flags.2?int type:tls.TypeExpr = tls.Arg;

tls.exprType _:tls.TypeExpr = tls.Expr;
tls.exprNat _:tls.NatExpr = tls.Expr;

tls.natConst value:int = tls.NatExpr;
tls.natVar dif:int var_num:int = tls.NatExpr;

tls.typeVar var_num:int flags:int = tls.TypeExpr;
tls.array multiplicity:tls.NatExpr args_num:# args:args_num*[tls.Arg] = tls.TypeExpr;
tls.typeExpr name:int flags:int children_num:# children:children_num*[tls.Expr] = tls.TypeExpr;
---functions---
---types---

rpcProxy.target host:int port:int actor_id:long = rpcProxy.Target;
rpcProxy.netTarget host:int port:int = rpcProxy.NetTarget;

---functions---
rpcProxy.getClusters = Vector long;
rpcProxy.getClusterSize actor_id:long = Maybe int;
rpcProxy.getClusterServers actor_id:long = Maybe (%Vector %rpcProxy.Target);
rpcProxy.getClusterStats actor_id:long = Maybe (%Stat);
rpcProxy.getBadTargets = Vector %rpcProxy.NetTarget;
---types---
/////
//
// Memcache
//
/////

memcache.not_found = memcache.Value;
memcache.strvalue value:string flags:int = memcache.Value;
memcache.longvalue value:long flags:int = memcache.Value;

---functions---

memcache.set key:string flags:int delay:int value:string = Bool;
memcache.add key:string flags:int delay:int value:string = Bool;
memcache.replace key:string flags:int delay:int value:string = Bool;
memcache.incr key:string value:long = memcache.Value;
memcache.decr key:string value:long = memcache.Value;
memcache.delete key:string = Bool;
memcache.get key:string = memcache.Value;

memcache.getWildcard prefix:string = Vector %(Map string string);
---types---
/////
//
// SeqMap
//
/////

seqmap.key key:%(Vector int) = seqmap.Key;
seqmap.value value:%(Vector int) = seqmap.Value;
seqmap.keyValue key:%seqmap.Key value:%seqmap.Value = seqmap.KeyValue;

---functions---

seqmap.set key:%seqmap.Key value:%seqmap.Value time:int = Bool;
seqmap.add key:%seqmap.Key value:%seqmap.Value time:int = Bool;
seqmap.replace key:%seqmap.Key value:%seqmap.Value time:int = Bool;
seqmap.delete key:%seqmap.Key = Bool;

seqmap.get key:%seqmap.Key = Maybe %seqmap.Value;

seqmap.getRange left:%seqmap.Key right:%seqmap.Key limit:int = VectorTotal %seqmap.KeyValue;
seqmap.getWildcard key:%seqmap.Key limit:int = VectorTotal %seqmap.KeyValue;

seqmap.getRangeCount left:%seqmap.Key right:%seqmap.Key = Int;
seqmap.getWildcardCount key:%seqmap.Key = Int;
---types---
/////
//
// Lists
//
/////

//  Flag bits:
//    0..2 sublist num
//    3  use sublist
//    4  descending order
//    5  sort by date
//    6  return with flags
//    7  return with date
//    8  return with global_id
//    9  return with value
//    10 return with text
//    11 return with ip
//    12 return with front_ip
//    13 return with port
//    14 return with ua_hash
//    15 return object_id

lists.listId {n:#} %(Tuple int n) = lists.ListId n;
lists.objectId {m:#} %(Tuple int m) = lists.ObjectId m;
lists.weightedObjectId {m:#} id:(%lists.ObjectId m) weight:int = lists.WeightedObjectId m;

lists.objectFull {m:#} {fields_mask:#} object_id:fields_mask.15?%(lists.ObjectId m) flags:fields_mask.6?int date:fields_mask.7?int global_id:fields_mask.8?long value:fields_mask.9?long text:fields_mask.10?string
      ip:fields_mask.11?int front_ip:fields_mask.12?int port:fields_mask.13?int ua_hash:fields_mask.14?int = lists.ObjectFull m fields_mask;

---functions---
lists.deleteList n:# m:# list_id:%(lists.ListId n) = Bool;
lists.deleteObject n:# m:# object_id:%(lists.ObjectId m) = BoolStat;
lists.deleteEntry n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) = Bool;

lists.setEntry n:# m:# list_id:%(lists.ListId n) mode:# entry:%(lists.objectFull m mode) = Bool;
lists.addEntry n:# m:# list_id:%(lists.ListId n) mode:# entry:%(lists.objectFull m mode) = Bool;
lists.replaceEntry n:# m:# list_id:%(lists.ListId n) mode:# entry:%(lists.objectFull m mode) = Bool;


//lists.setEntry n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int value:long ip:int front_ip:int port:int ua_hash:int = Bool;
//lists.setEntryShort n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int value:long = Bool;
//lists.addEntry n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int value:long ip:int front_ip:int port:int ua_hash:int = Bool;
//lists.addEntryShort n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int value:long = Bool;
//lists.replaceEntry n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int value:long ip:int front_ip:int port:int ua_hash:int = Bool;
//lists.replaceEntryShort n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int value:long = Bool;

lists.setEntryText n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) text:string = Bool;

lists.setFlags n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int = Bool;
lists.changeFlags n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) set_flags:int clear_flags:int = Bool;
lists.incrFlags n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int = Bool;
lists.decrFlags n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int = Bool;

lists.setValue n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) value:long = Maybe long;
lists.incrValue n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) value:long = Maybe long;
lists.decrValue n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) value:long = Maybe long;
lists.incrValueOrCreate n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int value:long = Maybe long;
lists.decrValueOrCreate n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) flags:int value:long = Maybe long;

lists.setListFlags n:# m:# list_id:%(lists.ListId n) flags:int new_flags:int = Bool;
lists.changeListFlags n:# m:# list_id:%(lists.ListId n) flags:int new_or_mask:int new_nand_mask:int = Bool;
lists.changeListFlagsEx n:# m:# list_id:%(lists.ListId n) xor_mask:int and_mask:int new_or_mask:int new_nand_mask:int = Bool;

lists.deleteSublist n:# m:# list_id:%(lists.ListId n) flags:int = Bool;
lists.deleteSublistEx n:# m:# list_id:%(lists.ListId n) xor_mask:int and_mask:int = Bool;

lists.getEntry n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) mode:# = Maybe (%lists.ObjectFull m mode);
lists.getEntryFlags n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) = Maybe int;
lists.getEntryDate n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) = Maybe int;
lists.getEntryValue n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) = Maybe long;
lists.getEntryGlobalId n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) = Maybe long;
lists.getEntryText n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) = Maybe string;
lists.getEntryPos n:# m:# list_id:%(lists.ListId n) object_id:%(lists.ObjectId m) = Int;

lists.getList n:# m:# list_id:%(lists.ListId n) mode:int = VectorTotal (%lists.ObjectId m);
lists.getListLimit n:# m:# list_id:%(lists.ListId n) mode:int limit:int offset:int = VectorTotal (%lists.ObjectId m);
lists.getListFull n:# m:# list_id:%(lists.ListId n) mode:# = VectorTotal (%lists.ObjectFull m mode);
lists.getListFullLimit n:# m:# list_id:%(lists.ListId n) mode:#  limit:int offset:int= VectorTotal (%lists.ObjectFull m mode);

lists.getListCount n:# m:# list_id:%(lists.ListId n) = Int;
lists.getSublistCount n:# m:# list_id:%(lists.ListId n) mode:int = Int;
lists.getSublistsCount n:# m:# list_id:%(lists.ListId n) = Tuple int 9;

lists.intersect n:# m:# list_id:%(lists.ListId n) mode:int object_list:%(Vector %(lists.ObjectId m)) = VectorTotal (%lists.ObjectId m);
lists.intersectLimit n:# m:# list_id:%(lists.ListId n) mode:int object_list:%(Vector %(lists.ObjectId m)) limit:int = VectorTotal (%lists.ObjectId m);
lists.intersectFull n:# m:# list_id:%(lists.ListId n) mode:# object_list:%(Vector %(lists.ObjectId m)) = VectorTotal (%lists.ObjectFull m mode);
lists.intersectFullLimit n:# m:# list_id:%(lists.ListId n) mode:# object_list:%(Vector %(lists.ObjectId m)) limit:int = VectorTotal (%lists.ObjectFull m mode);

lists.intersectWild n:# m:# list_id:%(lists.ListId n) k:# mode:int object_list:%(Vector %(lists.ObjectId k)) = VectorTotal (%lists.ObjectId m);
lists.intersectWildLimit n:# m:# list_id:%(lists.ListId n) k:# mode:int object_list:%(Vector %(lists.ObjectId k)) limit:int = VectorTotal (%lists.ObjectId m);
lists.intersectWildFull n:# m:# list_id:%(lists.ListId n) k:# mode:# object_list:%(Vector %(lists.ObjectId k)) = VectorTotal (%lists.ObjectFull m mode);
lists.intersectWildFullLimit n:# m:# list_id:%(lists.ListId n) k:# mode:# object_list:%(Vector %(lists.ObjectId k)) limit:int = VectorTotal (%lists.ObjectFull m mode);

lists.subtract n:# m:# list_id:%(lists.ListId n) mode:int object_list:%(Vector %(lists.ObjectId m)) = VectorTotal (%lists.ObjectId m);
lists.subtractLimit n:# m:# list_id:%(lists.ListId n) mode:int object_list:%(Vector %(lists.ObjectId m)) limit:int = VectorTotal (%lists.ObjectId m);

lists.sumlist n:# m:# list_id:%(lists.ListId n) mode:int object_list:%(Vector %(lists.ObjectId m)) = Long;
lists.sumlistWild n:# m:# list_id:%(lists.ListId n) k:# mode:int object_list:%(Vector %(lists.ObjectId k)) = Long;
lists.sumlistWeighted n:# m:# list_id:%(lists.ListId n) mode:int object_list:%(Vector %(lists.WeightedObjectId m)) = Long;
lists.sumlistWeightedWild n:# m:# list_id:%(lists.ListId n) k:# mode:int object_list:%(Vector %(lists.WeightedObjectId k)) = Long;

lists.sortedList n:# m:# list_id:%(lists.ListId n) xor_mask:int and_mask:int mode:int = VectorTotal (%lists.ObjectId m);
lists.sortedListLimit n:# m:# list_id:%(lists.ListId n) xor_mask:int and_mask:int mode:int limit:int = VectorTotal (%lists.ObjectId m);
lists.sortedListFull n:# m:# list_id:%(lists.ListId n) xor_mask:int and_mask:int mode:# = VectorTotal (%lists.ObjectFull m mode);
lists.sortedListFullLimit n:# m:# list_id:%(lists.ListId n) xor_mask:int and_mask:int mode:# limit:int = VectorTotal (%lists.ObjectFull m mode);

lists.datedistr n:# m:# list_id:%(lists.ListId n) mode:int min_date:int max_date:int step:int = Vector int;

---types---
/////
//
// Search
//
/////

//  Flag bits:
//    1  Sort
//    2  Sort descending (should be with +1)
//    3  Restrictions on rate/sate/bate ...
//    4  Search for exact hash
//    5  Group by hash
//    6  Use nate as hash
//    7  Use_relevance
//    8  Search only in title
//    9  Opttag coef
//    10 Rate weight
//    11 Priority weight
//    12 Decay time
//    13 Enable extended search mode
//    14 Enable occurance count
//    15 Random search
//    16 Weak search - up to 2 words missing

search.objectId {n:#} data:n*[int] = search.ObjectId n;
search.restrictions m:# data:m*[rate_type:int min_value:int max_value:int] = search.Restrictions;

search.oneResult {n:#} {flags:#} id:%(search.ObjectId n) rate:flags.1?int hash:flags.5?long = search.OneResult n flags;
search.result {flags:#} n:# results:%(VectorTotal %(search.OneResult n flags)) = search.Result flags;

search.oneNormalize rate_type:int weight:double fun:int = search.OneNormalize;
search.normalize n:# data:n*[search.OneNormalize] = search.Normalize;
---functions---

search.setRate n:# id:%(search.ObjectId n) rate_type:int rate_value:int = Bool;
search.incrRate n:# id:%(search.ObjectId n) rate_type:int rate_value:int = Bool;
search.decrRate n:# id:%(search.ObjectId n) rate_type:int rate_value:int = Bool;
search.getRate n:# id:%(search.ObjectId n) rate_type:int = Maybe int;

search.setHash n:# id:%(search.ObjectId n) hash:long = Bool;
search.getHash n:# id:%(search.ObjectId n) = Maybe long;

search.deleteItem  n:# id:%(search.ObjectId n) = Bool;
search.setItem n:# id:%(search.ObjectId n) rate:int sate:int text:string = Bool;

search.addTags n:# id:%(search.ObjectId n) tags:string = Bool;

search.deleteWithHash hash:long = BoolStat;
search.deleteWithHashes m:# hashes:m*[long] = BoolStat;

search.incrRateByHash rate_type:int rate:int m:# hashes:m*[long] = BoolStat;
search.changeRates m:# rate_type:int rates:m*[old:int new:int] = BoolStat;

search.search flags:# limit:int rate_type:flags.1?int restrictions:flags.3?%search.Restrictions hash:flags.4?long use_relevance:flags.7?double opttag_coeff:flags.9?double
  rate_normalize:flags.10?%search.Normalize priority_normalize:flags.11?double decay:flags.12?%search.OneNormalize hash_change:flags.6?int query:string = search.Result flags;
---types---

/////
//
// Statsx
//
/////

// Bits
// 0  : sex
// 1  : age
// 2  : mstatus
// 3  : political_views
// 4  : section
// 5  : city
// 6  : geoip_country
// 7  : country
// 8  : source
// 9  : views
// 10 : visitors
// 11 : sex_age
// 12 : visitors last month
// 13 : visitors last 7 days
// 14 : deletes
// 15 : version
// 16 : expires
// 17 : extra

statsx.intKey id:int count:int = statsx.IntKey;
statsx.strKey id:string count:int = statsx.StrKey;
statsx.month year:int month:int count:int = statsx.Month;

statsx.counter {mode:#} sex:mode.0?(%Tuple int 2) age:mode.1?(%Tuple int 8) marital_status:mode.2?(%Tuple int 8) political_views:mode.3?(%Tuple int 8) section:mode.4?(%Tuple int 16) city:mode.5?(%Vector %statsx.IntKey)
                        geoip_country:mode.6?(%Vector %statsx.StrKey) country:mode.7?(%Vector %statsx.StrKey) source:mode.8?(%Tuple int 16)
                        views:mode.9?int visitors:mode.10?int sex_age:mode.11?(%Tuple int 16) last_month_unique_visitors:mode.12?int last_week_unique_visitors:mode.13?int deletes:mode.14?int version:mode.15?int expires:mode.16?int
                        extra:mode.17?(%Vector %statsx.IntKey)
                        = statsx.Counter mode;

---functions---

statsx.incr cnt_id:long uid:int mode:# sex:mode.0?int age:mode.1?int marital_status:mode.2?int political_views:mode.3?int section:mode.4?int city:mode.5?int geoip_country:mode.6?string country:mode.7?string source:mode.8?int = Maybe int;
statsx.incrSubcnt cnt_id:long subcnt_id:int = Maybe int;

statsx.decr cnt_id:long uid:int mode:# sex:mode.0?int age:mode.1?int marital_status:mode.2?int political_views:mode.3?int section:mode.4?int city:mode.5?int geoip_country:mode.6?string country:mode.7?string source:mode.8?int = Maybe int;
statsx.decrSubcnt cnt_id:long subcnt_id:int = Maybe int;

statsx.incrVersion cnt_id:long version:int uid:int mode:# sex:mode.0?int age:mode.1?int marital_status:mode.2?int political_views:mode.3?int section:mode.4?int city:mode.5?int geoip_country:mode.6?string country:mode.7?string source:mode.8?int = Maybe int;
statsx.incrSubcntVersion cnt_id:long version:int subcnt_id:int = Maybe int;

statsx.decrVersion cnt_id:long version:int uid:int mode:# sex:mode.0?int age:mode.1?int marital_status:mode.2?int political_views:mode.3?int section:mode.4?int city:mode.5?int geoip_country:mode.6?string country:mode.7?string source:mode.8?int = Maybe int;
statsx.decrSubcntVersion cnt_id:long version:int subcnt_id:int = Maybe int;

statsx.getViews cnt_id:long = Maybe int;
statsx.getViewsVersion cnt_id:long version:int = Maybe int;

statsx.getVisitors cnt_id:long = Maybe int;
statsx.getVisitorsVersion cnt_id:long version:int = Maybe int;

statsx.enableCounter cnt_id:long = Bool;
statsx.disableCounter cnt_id:long = Bool;

statsx.setTimezone cnt_id:long offset:int = Bool;

statsx.getCounter cnt_id:long = Maybe (%statsx.Counter (262143));
statsx.getCounterVersion cnt_id:long version:int = Maybe (%statsx.Counter (262143));

statsx.getCounterMask cnt_id:long mode:# = Maybe (%statsx.Counter mode);
statsx.getCounterMaskVersion cnt_id:long mode:# version:int = Maybe (%statsx.Counter mode);

statsx.getVersions cnt_id:long = Maybe (%Vector int);

statsx.getMonthlyVisitors cnt_id:long = Maybe (%Vector %statsx.Month);
statsx.getMonthlyViews cnt_id:long = Maybe (%Vector %statsx.Month);

statsx.getCountersSum cnt_id:long from:int to:int = Maybe (%statsx.Counter (31 + 256 + 512 + 2048 + 16384));
---types---
/////
//
// Text
//
/////

//  Flag bits:
//    0  return with global_id
//    1  return with legacy_id
//    2  return with peer msg_id
//    3  return with cludges
//    4  return with text
//    5  return with flags
//    6  return with date
//    7  return with peer_id
//    8  return with ip
//    9  return with port
//    10 return with front
//    11 return with ua_hash
//    12 not used
//    13 not used
//    14 return with local_id
//    15 return with random_id
//    16..23 return with extra0...extra7
//    24..27 return with Extra0...Extra3

//text.messageNotFound {mode:#} = text.Message mode;
text.message {mode:#} local_id:mode.14?int global_id:mode.0?int legacy_id:mode.1?int peer_msg_id:mode.2?int flags:mode.5?int date:mode.6?int peer_id:mode.7?int ip:mode.8?int
  port:mode.9?int front:mode.10?int ua_hash:mode.11?long random_id:mode.15?long
  extra0:mode.16?int extra1:mode.17?int extra2:mode.18?int extra3:mode.19?int extra4:mode.20?int extra5:mode.21?int extra6:mode.22?int extra7:mode.23?int
  Extra0:mode.24?long Extra1:mode.25?long Extra2:mode.26?long Extra3:mode.27?long
  kludges:mode.3?string text:mode.4?string
  = text.Message mode;

text.messageFullId peer_id:int local_id:int = text.MessageFullId;
text.sublistType and_mask:int or_mask:int = text.SublistType;

text.eventOld event_id:int who:int data:int = text.EventOld;
text.eventBase event_id:int who:int data:int = text.Event;
text.eventEx event_id:int data:string = text.Event;

text.eventListOld timestamp:int num:# data:num*[text.EventOld] = text.EventListOld;
text.eventList timestamp:int events:%(Vector text.Event) = text.EventList;

text.onlineFriend {mode:#} id:int timestamp:mode.0?int = text.OnlineFriend mode;

text.resultSizeList total_size:int size:# data:size*[int] = text.ResultSizeList;

---functions---

text.getMessageShort uid:int local_id:int = Maybe %(text.Message (1 + 32 + 64 + 128 + 4096 + 2048));
text.getMessage uid:int local_id:int flags:# max_len:int = Maybe %(text.Message flags);

text.convertLegacyId uid:int legacy_id:int = Maybe int;
text.convertRandomId uid:int random_id:long = Maybe int;
text.peerMsgList uid:int peer:int from:int to:int = Maybe %(VectorTotal int);
text.peerMsgListPos uid:int peer:int local_id:int = Maybe int;

text.topMsgList uid:int from:int to:int = Maybe %(VectorTotal (%text.messageFullId));

text.sublistShort uid:int sublist:%text.SublistType from:int to:int = Maybe %(VectorTotal int);
text.sublist uid:int mode:# sublist:%text.SublistType from:int to:int = Maybe %(VectorTotal (%text.Message mode));
text.sublistPos uid:int sublist:%text.SublistType local_id:int = Maybe int;

text.sublistTypes = Vector %text.SublistType;
text.peermsgType = text.SublistType;

text.sendMessage uid:int mode:# message:%(text.Message mode) = Maybe int;
text.deleteMessage uid:int local_id:int = Bool;

text.deleteFirstMessages uid:int min_local_id:int = Bool;

text.getMessageFlags uid:int local_id:int = Maybe int;
text.setMessageFlags uid:int local_id:int flags:int = Bool;
text.incrMessageFlags uid:int local_id:int flags:int = Maybe int;
text.decrMessageFlags uid:int local_id:int flags:int = Maybe int;

text.getMessageextra uid:int local_id:int k:int = Maybe int;
text.setMessageextra uid:int local_id:int k:int value:int = Bool;
text.incrMessageextra uid:int local_id:int k:int value:int = Maybe int;
text.decrMessageextra uid:int local_id:int k:int value:int = Maybe int;

text.getMessageExtra uid:int local_id:int k:int = Maybe long;
text.setMessageExtra uid:int local_id:int k:int value:long = Bool;
text.incrMessageExtra uid:int local_id:int k:int value:long = Maybe long;
text.decrMessageExtra uid:int local_id:int k:int value:long = Maybe long;

text.deleteUserdata uid:int = Bool;
text.getUserdata uid:int = Maybe int;
text.loadUserdata uid:int force:int = Bool;

text.replaceMessageText uid:int local_id:int new_text:string = Bool;

text.getExtraMask = Tuple int 3;

text.setExtraMask mask:int = BoolStat;

text.search uid:int num:int query:string = Maybe %(VectorTotal int);
text.searchEx uid:int num:int query:string flags:# sublist:flags.0?%text.SublistType min_time:flags.1?int max_time:flags.1?int peer_id:flags.2?int = Maybe %(VectorTotal int);

text.getTimestamp uid:int = Maybe int;
text.getForceTimestamp uid:int = Maybe int;

//text.historyOld uid:int timestamp:int limit:int = Maybe %text.EventListOld;
text.history uid:int timestamp:int limit:int = Maybe %text.EventList;

text.historyAction uid:int event:text.Event = Bool;

text.getPTimestamp uid:int = Maybe int;

text.pHistory uid:int timestamp:int limit:int = Maybe %text.EventList;

text.online uid:int friends:(%Vector int) = BoolStat;
text.offline uid:int friends:(%Vector int) = BoolStat;

text.onlineFriends uid:int mode:# = Maybe %(Vector %(text.OnlineFriend mode));
text.onlineFriendsId uid:int = Maybe %(Vector int);

text.setSecret uid:int s:string = Bool;
text.getSecret uid:int = Maybe string;
text.deleteSecret uid:int = Bool;
---types---

/////
//
// Cache
//
/////

//  Flag bits:
//    0  return acounter value
//    1  return file size
//    2  return all acounter values
//    3  filter - URL with unknown size
//    4  filter - URL without local copies
//    5  return yellow_enabled
//    6  return yellow_remaining

cache.topAccessRecord {fields_mask:#} url:string value:fields_mask.0?double size:fields_mask.1?long values:fields_mask.2?%(Vector double) =  cache.TopAccessRecord fields_mask;
cache.bottomDiskRecord {fields_mask:#} local_url:string global_url:string value:fields_mask.0?double size:fields_mask.1?long values:fields_mask.2?%(Vector double) yellow_enabled:fields_mask.5?int yellow_remaining:fields_mask.6?int = cache.BottomDiskRecord fields_mask;
cache.yellowTime remaining:int enabled:int = cache.YellowTime;
cache.localCopy local_url:string node_id:int server_id:int disk_id:int flags:int cached_at:int = cache.LocalCopy;
cache.serverStat node_id:int server_id:int access_percent:double all_files_size:long files:long = cache.ServerStat;

---functions---
cache.access cache_id:int url:string = Bool;
cache.setFileSize cache_id:int url:string size:long = Bool;
cache.setYellowTimeRemaining cache_id:int global_url:string local_url:string time:int = Bool;
cache.setNewLocalCopy cache_id:int global_url:string local_url:string = Bool;
cache.deleteLocalCopy cache_id:int global_url:string local_url:string = Bool;

cache.disableServer cache_id:int node_id:int server_id:int = Bool;
cache.enableServer cache_id:int node_id:int server_id:int = Bool;
cache.disableDisk cache_id:int node_id:int server_id:int disk_id:int = Bool;
cache.enableDisk cache_id:int node_id:int server_id:int disk_id:int = Bool;
cache.deleteServer cache_id:int node_id:int server_id:int = Bool;
cache.deleteDisk cache_id:int node_id:int server_id:int disk_id:int = Bool;

cache.convert cache_id:int url:string = Maybe string;
cache.getFileSize cache_id:int url:string = Maybe long;
cache.getLocalCopies cache_id:int url:string = Maybe (%Vector %cache.LocalCopy);
cache.getYellowTime cache_id:int global_url:string local_url:string = Maybe (%cache.YellowTime);

cache.getTopAccess cache_id:int t:int limit:int flags:# min_rate:int = Vector (%cache.TopAccessRecord flags);
cache.getBottomAccess cache_id:int t:int limit:int flags:# min_rate:int = Vector (%cache.TopAccessRecord flags);
cache.getBottomDisk cache_id:int t:int limit:int flags:# node_id:int server_id:int disk_id:int = Vector (%cache.BottomDiskRecord flags);
cache.getTopDisk cache_id:int t:int limit:int flags:# node_id:int server_id:int disk_id:int = Vector (%cache.BottomDiskRecord flags);

cache.getAcounter cache_id:int url:string t:int = Maybe double;
cache.getServerStats cache_id:int sorting_flags:int = Vector (%cache.ServerStat);
---types---

/////
//
// Random
//
/////

---functions---
random.random n:int = Maybe string;
---types---

/////
//
// Storage
//
/////

storage.volumes volumes:%(Vector long) = storage.Volumes;
storage.fileLocation volume_id:long local_id:int secret:long = storage.FileLocation;
storage.fileUnknown = storage.FileType;
storage.fileJpeg = storage.FileType;
storage.fileGif = storage.FileType;
storage.filePng = storage.FileType;
storage.filePdf = storage.FileType;
storage.fileMp3 = storage.FileType;
storage.fileMov = storage.FileType;
storage.filePartial = storage.FileType;
storage.fileMp4 = storage.FileType;
storage.fileWebp = storage.FileType;
storage.fileContent volume_id:long local_id:int file_type:storage.FileType mtime:int content:string = storage.FileContent;
storage.fileForwardedInfo volume_id:long local_id:int file_type:storage.FileType mtime:int = storage.FileContent;
storage.globalPid ip:int port:int pid:int start_time:int = storage.GlobalPid;

---functions---

storage.getVolumes = storage.Volumes;
storage.checkFile volume_id:long file_size:long max_disk_used_space_percent:double = Bool;
storage.uploadFile volume_id:long file_data:string = storage.FileLocation;
storage.uploadFileExt volume_id:long file_type:storage.FileType file_data:string = storage.FileLocation;
storage.getFile location:storage.FileLocation = storage.FileContent;
storage.getFileIndirect location:storage.FileLocation fwd:%storage.GlobalPid fwd_header:%(Vector int) = storage.FileContent;
storage.getPart location:storage.FileLocation offset:int limit:int = storage.FileContent;
storage.getPartIndirect location:storage.FileLocation offset:int limit:int fwd:%storage.GlobalPid fwd_header:%(Vector int) = storage.FileContent;
---types---

/////
//
// Weights
//
/////

weights.update {n:#} vector_id:int relaxation_time:int vector:n*[int] = weights.Update n;
weights.smallUpdate vector_id:int coord_id:int relaxation_time:int value:int = weights.SmallUpdate;

---functions---
weights.setHalfLife coord_id:int half_life:int = BoolStat;
weights.incr vector_id:int coord_id:int value:int = Maybe int;
weights.at vector_id:int coord_id:int = Maybe int;
weights.getVector vector_id:int = Maybe (%Vector int);

//targ-engine to weights-engine
weights.subscribe vector_rem:int vector_mod:int coord_ids:%(Vector int) updates_start_time:int updates_seek_limit:int updates_limit:int small_updates_seek_limit:int small_updates_limit:int = Maybe %(Vector int);
//weights-engine to targ-engine
weights.sendUpdates n:# updates:(%Vector %(weights.Update n)) = Bool;
weights.sendSmallUpdates updates:(%Vector %weights.SmallUpdate) = Bool;
---types---
///////
//
// Friends
//
///////

friends.friend {mode:#} id:int mask:mode.0?int time:mode.1?int = friends.Friend mode;

---functions---

friends.deleteUser uid:int = Bool;

friends.getFriendsId uid:int mask:int = Maybe %(Vector int);
friends.getFriends uid:int mask:int mode:# = Maybe %(Vector %(friends.Friend mode));

friends.getFriendsCnt uid:int mask:int = Maybe int;

friends.getRecentFriends uid:int num:int = Maybe %(VectorTotal %(friends.Friend 3));

friends.setCatList uid:int cat:int friends:%(Vector int) = Bool;
friends.deleteCat uid:int cat:int = Bool;

friends.getFriend uid:int id:int = Maybe int;
friends.setFriend uid:int friend:int mask:int = Bool;
friends.replaceFriend uid:int friend:int mask:int = Bool;
friends.deleteFriend uid:int friend:int = Bool;
friends.incrFriend uid:int friend:int mask:int = Maybe int;
friends.decrFriend uid:int friend:int mask:int = Maybe int;


friends.getFriendReq uid:int id:int = Maybe int;
friends.addFriendReq uid:int friend:int mask:int = Bool;
friends.setFriendReq uid:int friend:int mask:int = Bool;
friends.replaceFriendReq uid:int friend:int mask:int = Bool;
friends.deleteFriendReq uid:int friend:int = Bool;
//friends.incrFriendReq uid:int mask:int = Bool;
//friends.decrFriendReq uid:int mask:int = Bool;

friends.deleteReqs uid:int = Bool;
friends.getReqs uid:int limit:int = Maybe %(VectorTotal %(friends.Friend 3));

friends.setPrivacy uid:int key:string text:string = Bool;
friends.replacePrivacy uid:int key:string text:string = Bool;
friends.getPrivacy uid:int key:string = Maybe string;
friends.deletePrivacy uid:int key:string = Bool;

friends.checkPrivacy uid:int test_uid:int key:string = Maybe int;
friends.checkPrivacyList uid:int test_uid:int key_lest:%(Vector string) = Vector (Maybe int);

friends.getCommonFriendsNum uid:int users:%(Vector int) = Vector int;
friends.getCommonFriends uid:int uid2:int = Vector Int;

---types---

/////
//
// News
//
/////

//news  - Newsfeed
//nnews - Notification news
//cnews - Comment news
//rnews - Recommendations news

news.typesGroup {flags:#} {size:#} int:flags.0?int vector:flags.1?(%Tuple int size) = news.TypesGroup flags size;
news.userIdsGroup {flags:#} {size:#} int:flags.2?int vector:flags.3?(%Tuple int size) = news.UserIdsGroup flags size;
news.datesGroup {flags:#} {size:#} int:flags.4?int vector:flags.5?(%Tuple int size) = news.DatesGroup flags size;
news.tagsGroup {flags:#} {size:#} int:flags.6?int vector:flags.7?(%Tuple int size) = news.TagsGroup flags size;
news.usersGroup {flags:#} {size:#} int:flags.8?int vector:flags.9?(%Tuple int size) = news.UsersGroup flags size;
news.groupsGroup {flags:#} {size:#} int:flags.10?int vector:flags.11?(%Tuple int size) = news.GroupsGroup flags size;
news.ownersGroup {flags:#} {size:#} int:flags.12?int vector:flags.13?(%Tuple int size) = news.OwnersGroup flags size;
news.placesGroup {flags:#} {size:#} int:flags.14?int vector:flags.15?(%Tuple int size) = news.PlacesGroup flags size;
news.itemsGroup {flags:#} {size:#} int:flags.16?int vector:flags.17?(%Tuple int size) = news.ItemsGroup flags size;

news.updatesGroup flags:# total_count:int size:#
  type:(%news.TypesGroup flags size) user_id:(%news.UserIdsGroup flags size) date:(%news.DatesGroup flags size)
  tag:(%news.TagsGroup flags size) user:(%news.UsersGroup flags size) group:(%news.GroupsGroup flags size)
  owner:(%news.OwnersGroup flags size) place:(%news.PlacesGroup flags size) item:(%news.ItemsGroup flags size)
    = news.UpdatesGroup;

//news.rawUpdatesRecord timestamp:int random_tag:int type:int user_id:int user:int group:int owner:int place:int item:int = news.RawUpdatesRecord;
news.rawUpdatesRecord user_id:int date:int random_tag:int type:int user:int group:int owner:int place:int item:int = news.RawUpdatesRecord;

cnews.objectId type:int owner:int place:int = cnews.ObjectId;
cnews.rawUpdatesRecord date:int random_tag:int type:int user:int group:int owner:int place:int item:int = cnews.RawUpdatesRecord;

nnews.getUpdatesRecord type:int owner:int place:int user:int item:int date:int = nnews.GetUpdatesRecord;
nnews.groupRecord user_id:int item:int date:int = nnews.GroupRecord;
//nnews.getGroupedUpdatesRecord type:int owner:int place:int groups:%(VectorTotal %nnews.GroupRecord) = nnews.GetGroupedUpdatesRecord;

//special meaning rates: -1 -> forbiden owner, -2 -> mandatory owner
rnews.ratedUser user:int rate:int = rnews.RatedUser;
rnews.rawUpdatesRecord type:int owner:int place:int acting_users:int weight:double = rnews.RawUpdatesRecord;

---functions---
news.update id:int type:int user:int group:int owner:int place:int item:int = Bool;
news.deleteUpdates id:int = Bool;
news.setPrivacyMask id:int type_mask:int = Bool;
news.getPrivacyMask id:int = Maybe int;

news.getRawUpdates type_mask:int start_date:int end_date:int user_list:%(Vector int) = Vector %news.RawUpdatesRecord;
news.getGroupedUpdates type_mask:int date:int timestamp:int end_date:int grouping:int limit:int user_list:%(Vector int) = Vector %news.UpdatesGroup;

cnews.update type:int owner:int place:int user:int group:int item:int = Bool;
cnews.deleteUpdates type:int owner:int place:int = Bool;
cnews.deleteUpdate type:int owner:int place:int item:int = Bool;
cnews.undeleteUpdate type:int owner:int place:int item:int = Bool;
cnews.getRawUpdates start_date:int end_date:int object_list:%(Vector %cnews.ObjectId) = Vector %cnews.RawUpdatesRecord;
cnews.getGroupedUpdates date:int timestamp:int end_date:int grouping:int limit:int object_list:%(Vector %cnews.ObjectId) = Vector %news.UpdatesGroup;
cnews.getRawUserUpdates type_mask:int start_date:int end_date:int user_id:int = Vector %cnews.RawUpdatesRecord;
cnews.getGroupedUserUpdates type_mask:int date:int timestamp:int end_date:int grouping:int limit:int user_id:int = Vector %news.UpdatesGroup;
cnews.addBookmark type:int owner:int place:int user_id:int = Bool;
cnews.delBookmark type:int owner:int place:int user_id:int = Bool;

nnews.update id:int type:int user:int owner:int place:int item:int = Bool;
nnews.deleteUpdates type:int owner:int place:int = BoolStat;
nnews.deleteUpdate type:int owner:int place:int item:int = BoolStat;
nnews.undeleteUpdate type:int owner:int place:int item:int = BoolStat;
nnews.deleteUserUpdate user_id:int type:int owner:int place:int item:int = Bool;
nnews.undeleteUserUpdate user_id:int type:int owner:int place:int item:int = Bool;
nnews.getUpdates user_id:int mask:int date:int end_date:int timestamp:int limit:int = Vector %nnews.GetUpdatesRecord;
nnews.getGroupedUpdates user_id:int mask:int date:int end_date:int grouping:int timestamp:int limit:int = Vector %news.UpdatesGroup;

rnews.update id:int type:int owner:int place:int action:int item:int item_creation_time:int = Bool;
rnews.setRate type:int action:int rate:double = BoolStat;
rnews.getRate type:int action:int = Maybe double;
rnews.getRawUpdates type_mask:int start_date:int end_date:int id:int t:int timestamp:int user_list:%(Vector %rnews.RatedUser) = Vector %rnews.RawUpdatesRecord;
rnews.getGroupedUpdates type_mask:int start_date:int end_date:int id:int t:int timestamp:int acting_users_limit:int limit:int user_list:%(Vector %rnews.RatedUser) = Vector %news.UpdatesGroup;
---types---
/////
//
// Hints
//
/////

hints.object type:int object_id:int = hints.Object;
hints.objectRating type:int object_id:int rating:double = hints.ObjectRating;
hints.objectText type:int object_id:int text:string = hints.ObjectText;
hints.objectFull type:int object_id:int rating:double text:string = hints.ObjectFull;

rating.object type:int object_id:int = rating.Object;
rating.objectRating type:int object_id:int rating:double = rating.ObjectRating;

---functions---

hints.nullifyRating  user_id:int = Bool;
hints.setRatingState user_id:int rating_enabled:Bool = Bool;
hints.setInfo        user_id:int info:int = Bool;
hints.setWinner      user_id:int type:int winner:int losers:%(Vector int) rating_num:int = Bool;
hints.setRating      user_id:int type:int object_id:int rating_num:int rating:double = Bool;
hints.setText        user_id:int type:int object_id:int text:string = Bool;
hints.setType        user_id:int type:int object_id:int new_type:int = Bool;
hints.setTextGlobal              type:int object_id:int text:string = BoolStat;
hints.setTypeGlobal              type:int object_id:int new_type:int = BoolStat;

hints.getInfo   user_id:int = Maybe int;
hints.sort      user_id:int limit:int rating_num:int objects:%(Vector %hints.Object) = Vector (%hints.Object);
hints.getRandom user_id:int limit:int rating_num:int objects:%(Vector %hints.Object) = Vector (%hints.Object);

//type = -1 for all types
//latin - search without translit and changing keyboard layout
hints.getHints            user_id:int type:int limit:int rating_num:int query:string = VectorTotal (%hints.Object);
hints.getHintsRating      user_id:int type:int limit:int rating_num:int query:string = VectorTotal (%hints.ObjectRating);
hints.getHintsText        user_id:int type:int limit:int rating_num:int query:string = VectorTotal (%hints.ObjectText);
hints.getHintsFull        user_id:int type:int limit:int rating_num:int query:string = VectorTotal (%hints.ObjectFull);
hints.getHintsLatin       user_id:int type:int limit:int rating_num:int query:string = VectorTotal (%hints.Object);
hints.getHintsLatinRating user_id:int type:int limit:int rating_num:int query:string = VectorTotal (%hints.ObjectRating);
hints.getHintsLatinText   user_id:int type:int limit:int rating_num:int query:string = VectorTotal (%hints.ObjectText);
hints.getHintsLatinFull   user_id:int type:int limit:int rating_num:int query:string = VectorTotal (%hints.ObjectFull);

hints.getObjectText  user_id:int type:int object_id:int = Maybe %String;

hints.deleteObject       user_id:int type:int object_id:int = Bool;
hints.deleteObjectGlobal             type:int object_id:int = BoolStat;
hints.incrementRating    user_id:int type:int object_id:int cnt:int rating_num:int = Bool;


rating.nullifyRating  user_id:int = Bool;
rating.setRatingState user_id:int rating_enabled:Bool = Bool;
rating.setInfo        user_id:int info:int = Bool;
rating.setWinner      user_id:int type:int winner:int losers:%(Vector int) rating_num:int = Bool;
rating.setType        user_id:int type:int object_id:int new_type:int = Bool;
rating.setRating      user_id:int type:int object_id:int rating_num:int rating:double = Bool;
rating.addObject      user_id:int type:int object_id:int = Bool;
rating.setTypeGlobal              type:int object_id:int new_type:int = BoolStat;

rating.getInfo   user_id:int = Maybe int;
rating.sort      user_id:int limit:int rating_num:int objects:%(Vector %rating.Object) = Vector (%rating.Object);
rating.getRandom user_id:int limit:int rating_num:int objects:%(Vector %rating.Object) = Vector (%rating.Object);

//type = -1 for all types
rating.getHints             user_id:int type:int limit:int rating_num:int exceptions:%(Vector %rating.Object) = VectorTotal (%rating.Object);
rating.getHintsRating       user_id:int type:int limit:int rating_num:int exceptions:%(Vector %rating.Object) = VectorTotal (%rating.ObjectRating);
rating.getRandomHints       user_id:int type:int limit:int rating_num:int exceptions:%(Vector %rating.Object) = VectorTotal (%rating.Object);
rating.getRandomHintsRating user_id:int type:int limit:int rating_num:int exceptions:%(Vector %rating.Object) = VectorTotal (%rating.ObjectRating);

rating.deleteObject       user_id:int type:int object_id:int = Bool;
rating.deleteObjectGlobal             type:int object_id:int = BoolStat;
rating.incrementRating    user_id:int type:int object_id:int cnt:int rating_num:int = Bool;

---types---
/////
//
// iSearch
//
/////

isearch.typeInfo n:# data:n*[type:int probability:double] = isearch.TypeInfo;

---functions---

isearch.addSearchQuery user_id:int type:int count:int query:string = Bool;

isearch.getHints query:string = Vector %String;
isearch.getTypes query:string = isearch.TypeInfo;
isearch.getSuggestion query:string = String;

isearch.getTop limit:int = Vector %String;
isearch.getBest limit:int = Vector %String;

isearch.addBlackList query:string = Bool;
isearch.deleteBlackList query:string = Bool;
isearch.getBlackList = Vector %String;
isearch.forceUpdateBlackList = Bool;
---types---
/////
//
// Photo
//
/////

photo.photoLocation server:int server2:int user_id:int orig_album:int photo:string = photo.PhotoLocation;

photo.audioLocation server:int server2:int user_id:int source:int audio:string = photo.AudioLocation;

photo.videoLocation server:int server2:int user_id:int source:int video:string = photo.VideoLocation;


photo.photoLocationStorage rotate:int size:string server:int volume_id:int local_id:int extra:int url_secret:string = photo.PhotoLocation;

photo.audioLocationStorage rotate:int size:string server:int volume_id:int local_id:int extra:int url_secret:string = photo.AudioLocation;

photo.videoLocationStorage rotate:int size:string server:int volume_id:int local_id:int extra:int url_secret:string = photo.VideoLocation;


// (fields_mask & (1 << 29)) == 1 means DELETED photo
// (fields_mask & (1 << 30)) is reserved for fields_mask2

photo.photo#2469893a fields_mask:#
                     id:fields_mask.0?int album_id:fields_mask.1?int owner_id:fields_mask.2?int user_id:fields_mask.3?int height:fields_mask.4?int width:fields_mask.5?int
                     location:fields_mask.6?(%Vector (photo.PhotoLocation)) original_location:fields_mask.7?(%Vector (photo.PhotoLocation)) = photo.Photo;

photo.audio#7ab683e6 fields_mask:#
                     id:fields_mask.0?int album_id:fields_mask.1?int owner_id:fields_mask.2?int uploaded:fields_mask.3?int
                     duration:fields_mask.4?int location:fields_mask.5?(%Vector (photo.AudioLocation)) = photo.Audio;

photo.video#cbb6b387 fields_mask:#
                     id:fields_mask.0?int album_id:fields_mask.1?int owner_id:fields_mask.2?int date:fields_mask.3?int title:fields_mask.4?string description:fields_mask.5?string
                     location:fields_mask.6?(%Vector (photo.VideoLocation)) flags:fields_mask.7?int = photo.Video;

photo.photoAlbum#691a0984 fields_mask:#
                          id:fields_mask.0?int owner_id:fields_mask.1?int title:fields_mask.2?string description:fields_mask.3?string = photo.PhotoAlbum;

photo.audioAlbum#c5a21f77 fields_mask:#
                          id:fields_mask.0?int owner_id:fields_mask.1?int title:fields_mask.2?string = photo.AudioAlbum;

photo.videoAlbum#7bbe3606 fields_mask:#
                          id:fields_mask.0?int owner_id:fields_mask.1?int title:fields_mask.2?string = photo.VideoAlbum;

---functions---

//changes of owner_id and id will be ignored
//changes of location and original_location will be added to previous values, changes of other fields will replace previous values
photo.changePhoto         owner_id:int photo_id:int changes:%photo.Photo         = Bool;
photo.changePhotoAlbum    owner_id:int album_id:int changes:%photo.PhotoAlbum    = Bool;
photo.changeAudio         owner_id:int photo_id:int changes:%photo.Audio         = Bool;
photo.changeAudioAlbum    owner_id:int album_id:int changes:%photo.AudioAlbum    = Bool;
photo.changeVideo         owner_id:int photo_id:int changes:%photo.Video         = Bool;
photo.changeVideoAlbum    owner_id:int album_id:int changes:%photo.VideoAlbum    = Bool;

photo.incrementPhotoField    owner_id:int photo_id:int field:string cnt:int = Bool;
photo.incrementAudioField    owner_id:int photo_id:int field:string cnt:int = Bool;
photo.incrementVideoField    owner_id:int photo_id:int field:string cnt:int = Bool;
photo.incrementAlbumField    owner_id:int album_id:int field:string cnt:int = Bool;

photo.setVolumeServer volume_id:int server_id:int = BoolStat;

photo.deleteLocationStorage         owner_id:int photo_id:int rotate:int size:string = Bool;
photo.deleteLocation                owner_id:int photo_id:int = Bool;
photo.deleteOriginalLocationStorage owner_id:int photo_id:int rotate:int size:string = Bool;
photo.deleteOriginalLocation        owner_id:int photo_id:int = Bool;

photo.changeLocationServer owner_id:int photo_id:int new_server_id:int = Bool;
photo.changeOriginalLocationServer owner_id:int photo_id:int new_server_id:int = Bool;
photo.changeLocationServer2 owner_id:int photo_id:int new_server_id:int = Bool;
photo.changeOriginalLocationServer2 owner_id:int photo_id:int new_server_id:int = Bool;

photo.savePhotoLocation owner_id:int photo_id:int = Bool;
photo.restorePhotoLocation owner_id:int photo_id:int = Bool;

photo.rotatePhoto owner_id:int photo_id:int dir:int = Bool;

photo.changePhotoOrder owner_id:int photo_id:int id_near:int is_next:Bool = Bool;
photo.changeAudioOrder owner_id:int photo_id:int id_near:int is_next:Bool = Bool;
photo.changeVideoOrder owner_id:int photo_id:int id_near:int is_next:Bool = Bool;
photo.changeAlbumOrder owner_id:int album_id:int id_near:int is_next:Bool = Bool;

photo.newPhotoForce owner_id:int album_id:int photo_id:int = Bool;
photo.newAudioForce owner_id:int album_id:int photo_id:int = Bool;
photo.newVideoForce owner_id:int album_id:int photo_id:int = Bool;
photo.newAlbumForce owner_id:int album_id:int              = Bool;

photo.newPhoto owner_id:int album_id:int = Maybe Int;
photo.newAudio owner_id:int album_id:int = Maybe Int;
photo.newVideo owner_id:int album_id:int = Maybe Int;
photo.newAlbum owner_id:int              = Maybe Int;

photo.getPhotosOverview          owner_id:int album_ids:%(Vector int) fields_mask:# offset:int limit:int is_reverse:Bool = Vector (%photo.Photo);
photo.getPhotosOverviewCount     owner_id:int album_ids:%(Vector int) fields_mask:# offset:int limit:int is_reverse:Bool = VectorTotal (%photo.Photo);

photo.getPhotosCount             owner_id:int album_id:int                                                    condition:string = Maybe Int;
photo.getAudiosCount             owner_id:int album_id:int                                                    condition:string = Maybe Int;
photo.getVideosCount             owner_id:int album_id:int                                                    condition:string = Maybe Int;
photo.getAlbumsCount             owner_id:int                                                                 condition:string = Maybe Int;

photo.getPhotos                  owner_id:int album_id:int fields_mask:# offset:int limit:int is_reverse:Bool condition:string = Vector (%photo.Photo);
photo.getPhotosWithCount         owner_id:int album_id:int fields_mask:# offset:int limit:int is_reverse:Bool condition:string = VectorTotal (%photo.Photo);
photo.getAudios                  owner_id:int album_id:int fields_mask:# offset:int limit:int is_reverse:Bool condition:string = Vector (%photo.Audio);
photo.getAudiosWithCount         owner_id:int album_id:int fields_mask:# offset:int limit:int is_reverse:Bool condition:string = VectorTotal (%photo.Audio);
photo.getVideos                  owner_id:int album_id:int fields_mask:# offset:int limit:int is_reverse:Bool condition:string = Vector (%photo.Video);
photo.getVideosWithCount         owner_id:int album_id:int fields_mask:# offset:int limit:int is_reverse:Bool condition:string = VectorTotal (%photo.Video);

photo.getPhotoAlbums             owner_id:int              fields_mask:# offset:int limit:int is_reverse:Bool condition:string = Vector (%photo.PhotoAlbum);
photo.getPhotoAlbumsWithCount    owner_id:int              fields_mask:# offset:int limit:int is_reverse:Bool condition:string = VectorTotal (%photo.PhotoAlbum);
photo.getAudioAlbums             owner_id:int              fields_mask:# offset:int limit:int is_reverse:Bool condition:string = Vector (%photo.AudioAlbum);
photo.getAudioAlbumsWithCount    owner_id:int              fields_mask:# offset:int limit:int is_reverse:Bool condition:string = VectorTotal (%photo.AudioAlbum);
photo.getVideoAlbums             owner_id:int              fields_mask:# offset:int limit:int is_reverse:Bool condition:string = Vector (%photo.VideoAlbum);
photo.getVideoAlbumsWithCount    owner_id:int              fields_mask:# offset:int limit:int is_reverse:Bool condition:string = VectorTotal (%photo.VideoAlbum);


// (fields_mask & (1 << 29)) == 1 means also return DELETED photos
photo.getPhoto         owner_id:int photo_id:int fields_mask:# = Maybe (%photo.Photo);
photo.getAudio         owner_id:int photo_id:int fields_mask:# = Maybe (%photo.Audio);
photo.getVideo         owner_id:int photo_id:int fields_mask:# = Maybe (%photo.Video);

photo.getPhotoAlbum    owner_id:int album_id:int fields_mask:# = Maybe (%photo.PhotoAlbum);
photo.getAudioAlbum    owner_id:int album_id:int fields_mask:# = Maybe (%photo.AudioAlbum);
photo.getVideoAlbum    owner_id:int album_id:int fields_mask:# = Maybe (%photo.VideoAlbum);

photo.restorePhoto owner_id:int photo_id:int = Bool;
photo.restoreAudio owner_id:int photo_id:int = Bool;
photo.restoreVideo owner_id:int photo_id:int = Bool;

photo.deletePhoto  owner_id:int photo_id:int = Bool;
photo.deleteAudio  owner_id:int photo_id:int = Bool;
photo.deleteVideo  owner_id:int photo_id:int = Bool;
photo.deleteAlbum  owner_id:int album_id:int = Bool;

---types---
/////
//
// Targ
//
/////


// Bits
//  0 like modificator r
//  1 like modificator i
//  2 reverse
//  17 and/xor mask
//  18 max_users_per_server
//  19 user_list

targ.adViewsCnt ad:int views:int = targ.AdViewsCnt;
targ.adUserViewsCnt user:int views:int = targ.AdUserViewsCnt;

targ.tAdInfo ad_id:long flags:long price:long users:long views:long clicked:long click_money:long unk1:long unk2:long unk3:long unk4:long expected_gain:long ext_users:long unk5:long l_sump0:long l_sump1:long l_sump2:long
  g_sump0:long g_sump1:long g_sump2:long lambda:long delta:long recent_views:long recent_views_limit:long factor:long domain:long group:long category:long subcategory:long = targ.AdInfo;


targ.pricesResult {limit:#} total:int res:%(Tuple int limit) = targ.PricesResult limit;
targ.audienceResult total:int scanned:int top_place:int = targ.AudienceResult;
targ.searchResult {mode:#} uid:int rate:mode.0?int = targ.SearchResult mode;


targ.userAd {flags:#} ad:int expected_gain:flags.0?int price:flags.1?int viewed:flags.2?int = targ.UserAd flags;

---functions---


targ.adEnable ad:int = BoolStat;
targ.adEnablePrice ad:int price:int = BoolStat;
targ.adDisable ad:int = BoolStat;
targ.adSetCtr ad:int clicks:long views:long = BoolStat;
targ.adSetSump ad:int sump0:long sump1:long sump2:long = BoolStat;
targ.adSetCtrSump ad:int clicks:long views:long sump0:long sump1:long sump2:long = BoolStat;
targ.adSetAud ad:int aud:int = BoolStat;
targ.adLimitedViews ad:int max_views:int = BoolStat;
targ.adViewsRateLimit ad:int max_views:int = BoolStat;
targ.adSites ad:int mask:int = BoolStat;
targ.adSetFactor ad:int factor:int = BoolStat;
targ.adSetDomain ad:int domain:int = BoolStat;
targ.adSetCategories ad:int category:int subcategory:int = BoolStat;
targ.adSetGroup ad:int group:int = BoolStat;

targ.adClicks ad:int = Maybe int;
targ.adCtr ad:int = Maybe (%Tuple int 4);
targ.adSump ad:int = Maybe (%Tuple int 9);
targ.adCtrSump ad:int = Maybe (%Tuple int 13);
targ.adMoney ad:int = Maybe int;
targ.adViews ad:int = Maybe int;
targ.adRecentViews ad:int = Maybe int;

targ.recentViewsStats mode:# limit:int = VectorTotal %targ.AdViewsCnt;
targ.recentAdViewers ad:int mode:# limit:int = VectorTotal %targ.AdUserViewsCnt;

targ.adInfo ad:int = Maybe %targ.AdInfo;
targ.adQuery ad:int = Maybe string;



targ.recentUserAds uid:int mode:# limit:int = Vector int;
targ.recentUserAdsCnt uid:int mode:# limit:int = Vector (%targ.AdViewsCnt);


targ.userGroups uid:int = Maybe %(Vector int);
targ.userClick uid:int ad:int price:int = Bool;
targ.userView uid:int ad:int = Bool;
targ.userFlags uid:int = Maybe int;
targ.userClickedAd uid:int ad:int = Maybe int;

targ.deleteGroup gid:int = BoolStat;

targ.target mode:# ad:int cost_per_click:int discount:mode.16?int query:string = Maybe int;
targ.prices mode:# place:int and_mask:mode.17?int xor_mask:mode.17?int limit:# user_list:mode.19?%(Vector int) query:string = targ.PricesResult limit;
targ.adPricing mode:# ad:int place:int and_mask:mode.17?int xor_mask:mode.17?int max_users_per_server:mode.18?int limit:# = targ.PricesResult limit;
//Size of vector is 3K+3
targ.targAudience mode:# place:int cpv:int and_mask:mode.17?int xor_mask:mode.17?int max_users_per_server:mode.18?int user_list:mode.19?%(Vector int) aux_queries:%(Vector string) query:string = Vector %targ.AudienceResult;
targ.audience mode:# user_list:mode.19?%(Vector int) aux_queries:%(Vector string) query:string = Vector int;
targ.search mode:# limit:int user_list:mode.19?%(Vector int) query:string = VectorTotal (%targ.SearchResult mode);

targ.userAds uid:int limit:int flags:# and_mask:flags.17?int or_mask:flags.17?int cat_mask:long = Vector %(targ.UserAd flags);

targ.setSex uid:int value:int = Bool;
targ.setOperator uid:int value:int = Bool;
targ.setBrowser uid:int value:int = Bool;
targ.setRegion uid:int value:int = Bool;
targ.setHeight uid:int value:int = Bool;
targ.setSmoking uid:int value:int = Bool;
targ.setAlcohol uid:int value:int = Bool;
targ.setPpriority uid:int value:int = Bool;
targ.setIiothers uid:int value:int = Bool;
targ.setHidden uid:int value:int = Bool;
targ.setCvisited uid:int value:int = Bool;
targ.setGcountry uid:int value:int = Bool;
targ.setPrivacy uid:int value:int = Bool;
targ.setPolitical uid:int value:int = Bool;
targ.setMstatus uid:int value:int = Bool;
targ.setTimezone uid:int value:int = Bool;
targ.setRate uid:int value:int = Bool;
targ.setCute uid:int value:int = Bool;
targ.setFlags uid:int value:int = Bool;
targ.setUserSingleGroupType uid:int value:int = Bool;
targ.setUserLang uid:int value:int = Bool;

targ.setCustom uid:int type:int value:int = Bool;
targ.setRates uid:int rate:int cute:int = Bool;
targ.setUsername uid:int value:string = Bool;
targ.setUserGroupTypes uid:int types:%(Vector int) = Bool;

targ.setCountryCity uid:int country:int city:int = Bool;
targ.setBirthday uid:int day:int month:int year:int = Bool;
targ.setReligion uid:int value:string = Bool;
targ.setHometown uid:int value:string = Bool;
targ.setProposal uid:int value:string = Bool;
targ.setSchool uid:int country:int city:int school:int start:int finish:int grad:int sch_class:int sch_type:int spec:string = Bool;
targ.setEducation uid:int country:int city:int university:int faculty:int chair:int grad_year:int edu_form:int edu_status:int primary:int = Bool;
targ.setCompany uid:int country:int city:int company:int start:int finish:int company_name:string job:string = Bool;
targ.setMilitary uid:int unit_id:int start:int finish:int = Bool;
targ.setAddress uid:int atype:int country:int city:int district:int station:int street:int name:string house:string = Bool;
targ.setInterest uid:int type:int name:string = Bool;
targ.setUserGroup uid:int group:int = Bool;

targ.deleteUser uid:int = Bool;
targ.deleteEducation uid:int = Bool;
targ.deleteSchools uid:int = Bool;
targ.deleteWork uid:int = Bool;
targ.deleteAddresses uid:int = Bool;
targ.deleteMilitary uid:int = Bool;
targ.deleteGroups uid:int = Bool;
targ.deletePositiveGroups uid:int = Bool;
targ.deleteNegativeGroups uid:int = Bool;
targ.deleteLangs uid:int = Bool;
targ.deleteProposal uid:int = Bool;
targ.deleteInterests uid:int type:int = Bool;
targ.deleteUserGroup uid:int group:int = Bool;
targ.deleteUserLang uid:int lang:int = Bool;

targ.deleteUserGroups uid:int groups:%(Vector int) = Bool;
targ.setUserGroups uid:int groups:%(Vector int) = Bool;
targ.addUserGroups uid:int groups:%(Vector int) = Bool;

targ.userVisit uid:int name:string = Bool;
---types---
/////
//
// Text
//
/////

//  Flag bits:

net.pid ip:int port_pid:int utime:int = net.Pid;

netUdpPacket.unencHeader flags:# remote_pid:flags.0?%Pid local_pid:flags.0?%Pid short_pids:flags.1?%(Tuple int 3) pid_hash:flags.2?long crypto_init:flags.3?int sha1:flags.4?%(Tuple int 16) random_key:flags.5?%(Tuple int 16) = netUdpPacket.UnencHeader;
netUdpPacket.encHeader flags:# random_block:flags.8?%(Tuple int 16) packet_ack:flags.12?int packet_ack_prefix:flags.13?int packet_ack_from:flags.14?int packet_ack_to:flags.14?int packet_ack_set:flags.15?%(Vector int)
  packet_num:flags.20?int packets_from:flags.21?int packets_to:flags.21?int prev_parts:flags.22?int next_parts:flags.23?int packed_num_parts:flags.24?%(Tuple int 2) = netUdpPacket.EncHeader;

udp.range from:int to:int = udp.Range;
udp.resendRequest from:int to:int = udp.ResendRequest;
udp.resendRequestExt msg_ids:%(Vector %udp.Range) = udp.ResendRequest;
udp.nop = True;

udp.obsoletePid pid:%net.Pid real_pid:%net.Pid generation:int = udp.ObsoletePid;

udp.obsoleteHash hash:long real_pid:%net.Pid = udp.ObsoleteHash;

udp.obsoleteGeneration pid:%net.Pid generation:int = udp.ObsoleteGeneration;

udp.disableEncryption = udp.DisableEncryption;
---functions---
