                        /* test connect with Sn and index function */

                        else if((rx_index.exactMatch(connect_options[i])) && (rx_serialNumber.exactMatch(connect_options[i])))
                        {
                            serialNumber = connect_options[i].mid(3);
                            connectWithSn = true;
                        }

                        /* test connect with Sn and index function */


            if((portName.size() == 4)&&(portName.startsWith("usb"))&&(portName.at(3).isDigit()))
            {
                /* execute new operator without calling the constructor
                               in oredr to avoid any sort of constructor failure
                               the "std::nothrow" is added to detect the initialisation
                               failure with a return value of "nullptr" */
                Target_Interface = new(std::nothrow) USBInterface;
                if(Target_Interface)
                {
                    ((BootloaderInterface*)Target_Interface)->loaderPath = extLoaderPath;
                    if (nbr_opt > 1)
                    {
                        for(int i=2; i<nbr_opt;i++)
                        {
                            if (rx_terminal.exactMatch(connect_options[i]))
                            {
                                isterminal = true;
                                bool ret = ((USBInterface*)Target_Interface)->connectTerminal(portName);
                                isConnected = ret ;
                            }
                            else
                            {
                                displayMng.logMessage(Error, L"Memory allocation failure");
                                displayMng.logMessage(Error, L"unable to connect to the target device");
                                exitCode = 1;
                                continue;
                            }
                        }
                    }
                    else
                    {
                        QString msg("Useless connect parameter with USB interface:");
                        for(int j= 2; j< nbr_opt; j++)
                            msg.append(" ").append(connect_options[j]);
                        displayMng.logMessage(Warning, L"%s", msg.toStdString().c_str());
                        exitCode = 1;
                    }
                }
            }
			
			
			
			