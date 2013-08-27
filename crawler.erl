-module(crawler).
-export([crawl/1, fetch/0]).

crawl([]) -> ok;
crawl([Url|List]) ->
    Pid = spawn(crawler, fetch, []),
    Pid ! Url,
    crawl(List).

fetch() ->
    receive
        Url ->
            {ok, {{_, Status, _}, _, _}} = httpc:request(Url),
            io:format("~b ~s~n", [Status, Url])
    end.
