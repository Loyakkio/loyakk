package com.loyakk.toolsapi.controller;

import com.loyakk.toolsapi.dto.PeerBasicDetails;
import com.loyakk.toolsapi.service.IPeerService;
import com.loyakk.toolsapi.utils.PeerConfig;
import org.dozer.DozerBeanMapper;
import org.dozer.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;

@RestController
public class PeerController {

    @Autowired
    private IPeerService iPeerService;

    /********************************************************************************************
     * Get the Basic Details of a Peer
     ********************************************************************************************/
    @RequestMapping(value = "/peer", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<PeerBasicDetails> getPeers (@RequestParam(value = "serverUrl", required = true) String serverUrl,
                                                      @RequestParam(value = "name", required = true) String name ) throws Exception {



        Mapper mapper = new DozerBeanMapper();

        // Call the Service to Save
        PeerBasicDetails peerBasicDetails =   iPeerService.getPeerStatus(serverUrl, name );


        if (peerBasicDetails != null) {
            return new ResponseEntity<PeerBasicDetails>(peerBasicDetails, HttpStatus.OK);
        } else
            return new ResponseEntity<PeerBasicDetails>(peerBasicDetails, HttpStatus.NO_CONTENT);


    }


    /********************************************************************************************
     * Stop a Peer
     ********************************************************************************************/
    @RequestMapping(value = "/peer/stop", method = RequestMethod.PUT)
    @ResponseBody
    public ResponseEntity<PeerBasicDetails> stopPeer (@RequestParam(value = "serverUrl", required = true) String serverUrl,
                                                      @RequestParam(value = "name", required = true) String name ) throws Exception {



        Mapper mapper = new DozerBeanMapper();

        // Call the Service to Save
        PeerBasicDetails peerBasicDetails =   iPeerService.stopPeer(serverUrl, name );


        if (peerBasicDetails != null) {
            return new ResponseEntity<PeerBasicDetails>(peerBasicDetails, HttpStatus.OK);
        } else
            return new ResponseEntity<PeerBasicDetails>(peerBasicDetails, HttpStatus.NO_CONTENT);


    }

    /********************************************************************************************
     * Start a Peer
     ********************************************************************************************/
    @RequestMapping(value = "/peer/start", method = RequestMethod.PUT)
    @ResponseBody
    public ResponseEntity<PeerConfig> startPeer (@RequestParam(value = "serverUrl", required = true) String serverUrl,
                                                 @RequestParam(value = "name", required = true) String name ) throws Exception {



        Mapper mapper = new DozerBeanMapper();

        // Call the Service to Save
        PeerConfig peerConfig =   iPeerService.startPeer(serverUrl, name );


        if (peerConfig != null) {
            return new ResponseEntity<PeerConfig>(peerConfig, HttpStatus.OK);
        } else
            return new ResponseEntity<PeerConfig>(peerConfig, HttpStatus.NO_CONTENT);


    }

    /********************************************************************************************
     * Create   a Peer
     ********************************************************************************************/
    @RequestMapping(value = "/peer/create", method = RequestMethod.PUT)
    @ResponseBody
    public ResponseEntity<PeerConfig> createAndStartPeer (@RequestBody PeerConfig peerConfig) throws Exception {



        Mapper mapper = new DozerBeanMapper();

        // Call the Service to Save
        peerConfig =   iPeerService.createPeer(peerConfig);


        if (peerConfig != null) {
            return new ResponseEntity<PeerConfig>(peerConfig, HttpStatus.OK);
        } else
            return new ResponseEntity<PeerConfig>(peerConfig, HttpStatus.NO_CONTENT);
    }

    @ModelAttribute
    public void setVaryResponseHeader(HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
    }



}
