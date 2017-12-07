package com.loyakk.toolsapi.controller;

import com.loyakk.toolsapi.domain.loyakkChannel;
import com.loyakk.toolsapi.dto.BlockDetail;
import com.loyakk.toolsapi.dto.TransactionResponse;
import com.loyakk.toolsapi.service.IBlockReaderService;
import com.loyakk.toolsapi.utils.ChaincodeFunctionAndParameters;
import org.hyperledger.fabric.sdk.exception.CryptoException;
import org.hyperledger.fabric.sdk.exception.InvalidArgumentException;
import org.hyperledger.fabric.sdk.exception.ProposalException;
import org.hyperledger.fabric.sdk.exception.TransactionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.spec.InvalidKeySpecException;
import java.util.HashMap;
import java.util.List;


@RestController
public class BlockReaderController {

    @Autowired
    private IBlockReaderService iBlockReaderService;


    /********************************************************************************************
     * Submit Query to a Chain Code
     ********************************************************************************************/
    @RequestMapping(value = "/blockdetail", method = RequestMethod.PUT)
    @ResponseBody
    public ResponseEntity<BlockDetail> findById (@RequestParam(value = "channelname", required = true) String channelName,
                                                 @RequestParam (value = "username", required = true) String userName,
                                                 @RequestParam(value = "orgunitname", required = true) String orgUnitName,
                                                 @RequestParam(value = "id", required = true) Integer blockNumber)
            throws ProposalException, InvalidArgumentException, NoSuchAlgorithmException, IOException, TransactionException,                                    NoSuchProviderException, CryptoException, InvalidKeySpecException {




        BlockDetail blockDetail = iBlockReaderService.getBlock(channelName,userName,orgUnitName,blockNumber);

        if (blockDetail != null) {
            return new ResponseEntity<BlockDetail>(blockDetail, HttpStatus.OK);
        } else
            return new ResponseEntity<BlockDetail>(blockDetail, HttpStatus.BAD_REQUEST);

    }

    @ModelAttribute
    public void setVaryResponseHeader(HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
    }
}
