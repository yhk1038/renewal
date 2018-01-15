$app = {
    config: {
        env: check_env()
    }
};

function check_env() {
    var env = 'production';
    if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'){
        env = 'development';
    }
    return env
}