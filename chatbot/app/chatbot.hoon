/-  gs=graph-store, gspost=post
/+  *chatbot, default-agent, dbug, graph, gslib=graph-store, sig=signatures
|%
+$  versioned-state
  $%  state-0
  ==
::
+$  state-0  [%0 count=@]
::
+$  card  card:agent:gall
::
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this      .
    default   ~(. (default-agent this %|) bowl)
    hc      ~(. +> bowl)
::
++  on-init
  ^-  (quip card _this)
  ~&  >  '%chatbot launched'
  =.  state  [%0 count=0]
  [~[(subscribe:hc)] this]
++  on-save
  ^-  vase
  !>(state)
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  ~&  >  'chatbot reloaded'
  =/  prev  !<(versioned-state old-state)
  ?-  -.prev
    %0
    `this(state prev)
  ==
++  on-poke  on-poke:default
++  on-arvo   on-arvo:default
++  on-watch  on-watch:default
++  on-leave  on-leave:default
++  on-peek   on-peek:default
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  (on-agent:default wire sign)
    [%dcspark-chatbot *]
    ?-  -.sign
      %watch-ack
        ~&  >   "subscribed on wire {<wire>} successfully"
        `this
      %fact  
        =/  incoming-post  (parse-incoming:hc cage.sign)
        ?~  incoming-post  `this
        =/  post  (need incoming-post)
        ?:  =(our.bowl author.post)  `this
        =/  reaction  (get-reaction:hc post)
        ?~  reaction  `this
        =/  reply-card  (build-poke:hc reaction resource.post)
        [[reply-card ~] this(count +(count))]
      %poke-ack
        ~&  >  "poke acked on {<wire>} successfully"
        `this
      %kick
        ~&  >  "kicked from subscription {<wire>}"
        ~&  >  "resubscribing"
        [~[(subscribe:hc)] this]
    ==
  ==
++  on-fail   on-fail:default
--
|_  =bowl:gall
++  subscribe
  |. 
  ^-  card
  =/  task  `task:agent:gall`[%watch /updates]
  ~&  >  "building subscription"
  =/  ship  `[@p @tas]`[our.bowl %graph-store]
  =/  note  `note:agent:gall`[%agent ship task]
  =/  wire  `wire`/dcspark-chatbot/(scot %p our:bowl)/(scot %da now:bowl)
  =/  card  `card`[%pass wire note]
  card
++  parse-incoming
  |=  =cage
  ^-  (unit parsed)
  =/  incoming-post=(unit parsed)  
  (extract-post !<(update:gs q.cage))
  ?~  incoming-post  ~
  =/  post  (need incoming-post)
  ~&  >>>  post
  ?~  index.post  ~
  `post
++  get-reaction
  |=  post=parsed
  ^-  (list content:gspost)
  =/  tag  author.post
  =/  reply-content  (extract-first-text contents.post)
  ?~  reply-content  ~
  (react tag (need reply-content))
++  build-poke
  |=  [reaction=(list content:gspost) =resource]
  ^-  card:agent:gall
  =/  reply-post  (build-post reaction now.bowl our.bowl)
  =/  reply-node  (build-node reply-post)
  =/  reply-action  (build-action reply-node resource)
  =/  reply-update  (build-update reply-action now.bowl)
  (build-graph-store-poke-card reply-update resource now.bowl our.bowl)
++  react
  |=  [tag=@p text=@t]
  ^-  (list content:gspost)
  ?:  =('!help' text)  ~[[%text text=(help-message)]]
  ?:  =('.' text)  ~[[%mention ship=tag] [%text text=': ack']]
  ?:  =('o7' text)  ~[[%text text='o7']]
  ?:  =('!start' text)  (start)  ~
++  help-message
|.
'''
Gerhana Bot
```
!start   -> Kickstart your exploration
!help    -> Display this menu
.        -> Your dot will be acked automatically
o7       -> o7
```
'''
::

++  start
  |.
  ^-  (list content:gspost)
  :~  :-  %text  =/  text
      '''
      *Welcome to Gerhana* 🌘 *Here are some links to get you started:*
      🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹
      **🛗  Common Places:**
      '''  text
      [%reference reference=[%group group=[entity=~hocwyn-tipwex name=%uqbar-event-horizon]]]
      [%reference reference=[%group group=[entity=~rondev name=%group-discovery]]]
      [%reference reference=[%group group=[entity=~middev name=%the-forge]]]
      :-  %text  =/  text
      '''
      **Full List:**
      '''  text
      [%reference reference=[%graph group=[entity=~donpub-datdux name=%gerhana-network] uid=[resource=[entity=~walrus-donpub-datdux name=%directory-1215] index=~]]]
      :-  %text  =/  text
      '''
      🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹
      **📦 To Improve Your Experience:**
      '''  text
      [%reference reference=[%app ship=~dister-fabnev-hinmur desk=%escape path=/]]
      [%reference reference=[%app ship=~pocwet desk=%journal path=/]]
      [%reference reference=[%app ship=~paldev desk=%rumors path=/]]
      :-  %text  =/  text
      '''
      **Full List:**
      '''  text
      [%reference reference=[%graph group=[entity=~donpub-datdux name=%gerhana-network] uid=[resource=[entity=~walrus-donpub-datdux name=%apps-9060] index=~]]]
      :-  %text  =/  text
      '''
      🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹
      **Note:** Use `!help` to see all commands!
      '''  text
::      [%url url='https://gerhana.network']
::      [%text text='*website is not ready*']
  ==
--
