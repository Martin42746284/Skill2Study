import { useState } from "react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";
import {
  Building2,
  MapPin,
  GraduationCap,
  BookOpen,
  Globe,
  Phone,
  X,
  ChevronRight,
  ExternalLink,
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";

export interface MapParcours {
  id: number;
  nom: string;
  specialisation?: string | null;
}

export interface MapFiliere {
  id: number;
  nom: string;
  domaine?: string | null;
  specialite?: string | null;
  niveau?: string | null;
  parcours?: MapParcours[];
}

export interface CityUniversity {
  id: number;
  nom: string;
  type: string;
  ville: string;
  wilaya?: string | null;
  adresse?: string | null;
  site_web?: string | null;
  telephone?: string | null;
  logo_url?: string | null;
  filieres?: MapFiliere[];
}

export interface CityMarker {
  id: string;
  name: string;
  lat: number;
  lng: number;
  universities: CityUniversity[];
}

interface CityInfoPanelProps {
  selectedCity: CityMarker | null;
  onClose: () => void;
  onUniversitySelect?: (university: any) => void;
  selectedUniversity?: any;
}

const formatUniversityType = (type: string) => {
  if (type === "publique") return "Public";
  if (type === "privee") return "Privé";
  return type;
};

const CityInfoPanel = ({ selectedCity, onClose, onUniversitySelect, selectedUniversity }: CityInfoPanelProps) => {
  const [expandedUni, setExpandedUni] = useState<number | null>(null);

  return (
    <AnimatePresence mode="wait">
      {selectedCity ? (
        <motion.div
          key={selectedCity.id}
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          exit={{ opacity: 0, x: 20 }}
          transition={{ duration: 0.25 }}
          className="w-full lg:w-[440px] shrink-0 h-full flex flex-col"
        >
          <div className="rounded-xl border bg-card shadow-sm overflow-hidden flex flex-col h-full">
            <div className="p-5 bg-primary/5 border-b shrink-0">
              <div className="flex items-start justify-between">
                <div>
                  <h2 className="text-xl font-bold">{selectedCity.name}</h2>
                  <p className="text-sm text-muted-foreground flex items-center gap-1 mt-0.5">
                    <MapPin className="h-3.5 w-3.5" /> Madagascar
                  </p>
                </div>
                <Button variant="ghost" size="icon" className="h-8 w-8" onClick={onClose}>
                  <X className="h-4 w-4" />
                </Button>
              </div>
              <div className="flex gap-3 mt-3 flex-wrap">
                <Badge variant="secondary" className="text-xs">
                  <Building2 className="h-3 w-3 mr-1" />
                  {selectedCity.universities.length} université(s)
                </Badge>
                <Badge variant="secondary" className="text-xs">
                  <GraduationCap className="h-3 w-3 mr-1" />
                  {selectedCity.universities.reduce((s, u) => s + (u.filieres?.length || 0), 0)} filière(s)
                </Badge>
              </div>
            </div>

            <div className="divide-y flex-1 overflow-y-auto">
              {selectedCity.universities.map((uni) => {
                const isExpanded = expandedUni === uni.id;
                const filieres = uni.filieres || [];

                return (
                  <div key={uni.id} className={`group overflow-hidden ${selectedUniversity?.id === uni.id ? "bg-primary/5 border-l-4 border-primary" : ""}`}>
                    <div
                      className="p-4 cursor-pointer hover:bg-muted/30 transition-colors"
                      onClick={() => {
                        setExpandedUni(isExpanded ? null : uni.id);
                        if (onUniversitySelect && selectedCity) {
                          onUniversitySelect({
                            id: uni.id,
                            nom: uni.nom,
                            lat: selectedCity.lat,
                            lng: selectedCity.lng
                          });
                        }
                      }}
                    >
                      <div className="flex items-start gap-3">
                        <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-primary/10 overflow-hidden">
                          {uni.logo_url ? (
                            <img
                              src={uni.logo_url}
                              alt={uni.nom}
                              className="h-full w-full object-cover"
                              onError={(e) => {
                                (e.target as HTMLImageElement).style.display = 'none';
                              }}
                            />
                          ) : (
                            <Building2 className="h-5 w-5 text-primary" />
                          )}
                        </div>
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2">
                            <h3 className="font-semibold text-sm">{uni.nom}</h3>
                            <ChevronRight
                              className={`h-3.5 w-3.5 text-muted-foreground transition-transform ${isExpanded ? "rotate-90" : ""}`}
                            />
                          </div>
                          <div className="flex items-center gap-2 mt-1 flex-wrap">
                            <Badge variant="outline" className="text-[10px]">
                              {formatUniversityType(uni.type)}
                            </Badge>
                            <span className="text-xs text-muted-foreground">{uni.ville}</span>
                            <span className="text-xs text-muted-foreground">
                              {filieres.length} filière{filieres.length > 1 ? "s" : ""}
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>

                    <AnimatePresence>
                      {isExpanded && (
                        <motion.div
                          initial={{ height: 0, opacity: 0 }}
                          animate={{ height: "auto", opacity: 1 }}
                          exit={{ height: 0, opacity: 0 }}
                          transition={{ duration: 0.2 }}
                          className="overflow-hidden"
                        >
                          <div className="px-4 pb-4 space-y-3">
                            <div className="flex flex-wrap gap-3 text-xs text-muted-foreground">
                              {uni.site_web && (
                                <span className="flex items-center gap-1 break-all">
                                  <Globe className="h-3 w-3" /> {uni.site_web}
                                </span>
                              )}
                              {uni.telephone && (
                                <span className="flex items-center gap-1">
                                  <Phone className="h-3 w-3" /> {uni.telephone}
                                </span>
                              )}
                            </div>
                            <div className="space-y-2">
                              <p className="text-xs font-semibold flex items-center gap-1">
                                <GraduationCap className="h-3.5 w-3.5 text-primary" /> Filières
                              </p>
                              {filieres.length === 0 ? (
                                <div className="rounded-lg border bg-muted/30 p-3 text-xs text-muted-foreground">
                                  Aucune filière disponible.
                                </div>
                              ) : (
                                filieres.map((filiere) => (
                                  <div key={filiere.id} className="rounded-lg border bg-muted/30 p-2.5">
                                    <div className="flex items-center justify-between gap-2">
                                      <p className="text-xs font-medium">{filiere.nom}</p>
                                      {filiere.niveau && (
                                        <Badge variant="secondary" className="text-[10px] font-normal">
                                          {filiere.niveau}
                                        </Badge>
                                      )}
                                    </div>
                                    <div className="mt-1 flex flex-wrap gap-1">
                                      {(filiere.parcours || []).map((parcours) => (
                                        <Badge key={parcours.id} variant="secondary" className="text-[10px] font-normal">
                                          <BookOpen className="h-2.5 w-2.5 mr-0.5" /> {parcours.nom}
                                        </Badge>
                                      ))}
                                    </div>
                                  </div>
                                ))
                              )}
                            </div>
                            <Link to={`/university/${uni.id}`}>
                              <Button variant="outline" size="sm" className="w-full mt-2">
                                <ExternalLink className="h-3.5 w-3.5 mr-1.5" />
                                Voir les détails complets
                              </Button>
                            </Link>
                          </div>
                        </motion.div>
                      )}
                    </AnimatePresence>
                  </div>
                );
              })}
            </div>
          </div>
        </motion.div>
      ) : (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="w-full lg:w-[440px] shrink-0 h-full rounded-xl border bg-card p-8 shadow-sm flex flex-col items-center justify-center text-center text-muted-foreground"
        >
          <MapPin className="h-10 w-10 mb-3 opacity-30" />
          <p className="font-medium">Sélectionnez une ville</p>
          <p className="text-sm mt-1">
            Cliquez sur un marqueur sur la carte pour voir les établissements disponibles dans cette ville.
          </p>
        </motion.div>
      )}
    </AnimatePresence>
  );
};

export default CityInfoPanel;
