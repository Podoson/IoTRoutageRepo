
simple Server
{
    parameters:
        @display("i=device/antennatower_l");
        @signal[receiveBegin](type="long");  // increases with each new frame arriving to the server and drops to 0 if the channel becomes finally idle
        @signal[receive](type="long");  // for successful receptions (non-collisions): 1 at the start of the reception, 0 at the end of the reception
        @signal[collision](type="long"); // the number of collided frames at the beginning of the collision period
        @signal[collisionLength](type="simtime_t");  // the length of the last collision period at the end of the collision period
        @signal[channelState](type="long");

		double txRate @unit(bps);          // transmission rate
		volatile double iaTime @unit(s);   // packet interarrival time
		volatile int pkLenBits @unit(b);   // packet length in bits
        
        double sinkX @unit(m); // the x coordinate of the server
        double sinkY @unit(m); // the y coordinate of the server
        int numHosts;  // number of hosts 
        
        double SbWidth @unit(m); 
        double SbHeight @unit(m);

        double animationHoldTimeOnCollision @unit(s) = default(0s); // in animation time

        @statistic[serverChannelState](source="channelState";title="Channel state";enum="IDLE=0,TRANSMISSION=1,COLLISION=2";record=vector);
        @statistic[receiveBegin](source="receiveBegin"; record=vector?; interpolationmode=sample-hold; title="receive begin");
        @statistic[channelUtilization](source="timeavg(receive)"; record=last; interpolationmode=linear; title="channel utilization");
        @statistic[collisionMultiplicity](source=collision; record=vector?,histogram; title="collision multiplicity");
        @statistic[collisionLength](record=vector?,histogram,mean,sum,max; title="collision length");
        @statistic[receivedFrames](source="sum(receive)"; record=last; title="received frames");
        @statistic[collidedFrames](source="sum(collision)"; record=last; title="collided frames");
        
//        int sinkList[4]; // liste des autres sinks
//        int hostsNeighbors[numHosts] // liste de des neaud du cluster
//        int itemsToSend[5*hostMemorySize];// liste des objets pour chaque cluster avec leur sink
        
    gates:
        input in @directIn;
}

