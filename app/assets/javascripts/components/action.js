$server_port = 3000;
$server_host = $app.config.env === 'development' ? 'http://localhost:'+$server_port : 'http://';


$router = {
    view_count: function (action, id) { return restful_balancor('view_counts', action, id) },
    like:       function (action, id) { return restful_balancor('likes', action, id) },
    bookmark:   function (action, id) { return restful_balancor('bookmarks', action, id) },
    subscribe:  function (action, id) { return restful_balancor('subscribes', action, id) }
};




function request(resource, action, id, data) {
    var rest;
    if (resource === 'view_count')      {rest = $router.view_count(action, id);}
    else if (resource === 'like')       {rest = $router.like(action, id);}
    else if (resource === 'bookmark')   {rest = $router.bookmark(action, id);}
    else if (resource === 'subscribe')  {rest = $router.subscribe(action, id);}

    var structure = {};
    structure.authenticity_token = _form_auth_;
    structure[resource] = data;

    var call = $.ajax({
        url: rest.path,
        method: rest.method,
        data: structure
    });
    call.done(function (data) { success_process(data) });
    call.fail(function (data) { error_process(data) });
}

function success_process(data) {
    // console.log(data);
}
function error_process(data) {
    // console.log(data);
}




function restful_balancor(resource, action, id){
    var restful = restful_generator(resource, action, id);
    return {path: $server_host+restful.path+'.json', method: restful.method}
}
function restful_generator(resource, action, id) {
    var method, path;
    if (action === 'index')         { method = 'get';       path = '/'+resource; }
    else if (action === 'create')   { method = 'post';      path = '/'+resource; }
    else if (action === 'show')     { method = 'get';       path = '/'+resource+'/'+id; }
    else if (action === 'update')   { method = 'put';       path = '/'+resource+'/'+id; }
    else if (action === 'destroy')  { method = 'delete';    path = '/'+resource+'/'+id; }
    else { method = ''; path = ''; }
    return {method: method, path: path}
}
