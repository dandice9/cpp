#include <iostream>
#include <boost/asio.hpp>
#include <libpq-fe.h>

int main(){
    boost::asio::io_context io;
    boost::asio::steady_timer t(io, boost::asio::chrono::seconds(10));
    t.wait();
    int libpq_ver = PQlibVersion();
    printf("Version of libpq: %d\n", libpq_ver);
    std::cout << "hello world, works!!" << std::endl;
    
    return 0;
}